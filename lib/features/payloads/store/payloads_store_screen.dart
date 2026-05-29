import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/payload.dart';
import '../../../data/services/digispark_converter.dart';
import '../../../data/services/github_store/models.dart';
import '../../../data/services/github_store/url_parser.dart';
import '../../../state/controllers/payloads_controller.dart';
import '../../../state/controllers/payloads_store_controller.dart';
import '../../../state/providers.dart';
import 'manage_sources_screen.dart';

import '../../../extension/context_extensions.dart';

class PayloadsStoreScreen extends ConsumerStatefulWidget {
  const PayloadsStoreScreen({super.key});

  @override
  ConsumerState<PayloadsStoreScreen> createState() => _PayloadsStoreScreenState();
}

class _PayloadsStoreScreenState extends ConsumerState<PayloadsStoreScreen> {
  final TextEditingController _urlCtrl = TextEditingController();
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load last repo from prefs and prefill text field.
    Future.microtask(() async {
      await ref.read(payloadsStoreControllerProvider.notifier).loadLastFromPrefs();
      final s = ref.read(payloadsStoreControllerProvider);
      _urlCtrl.text = s.repo?.originalUrl ?? '';

      if (mounted && s.repo != null) {
        ref.read(payloadsStoreControllerProvider.notifier).refresh(context.l10n);
      }
    });
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final state = ref.watch(payloadsStoreControllerProvider);
    final ctrl = ref.read(payloadsStoreControllerProvider.notifier);
    final repo = state.repo;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.payloadsStore),
        actions: [
          IconButton(
            tooltip: context.l10n.sources,
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ManageSourcesScreen()),
            ),
          ),
         IconButton(
           tooltip: context.l10n.showAllIncludingHidden,
           icon: const Icon(Icons.visibility),
           onPressed: repo == null
               ? null
               : () async {
                   // toggle persisted flag via controller (notifier-level) using prefs
                   final prefs = await ref.read(prefsStorageProvider.future);
                   final current = (prefs.getString('tapducky.store.showAll') ?? '') == '1';
                   await prefs.setString('tapducky.store.showAll', current ? '0' : '1');
                   // force reload
                   ctrl.refresh(context.l10n);
                 },
         ),
         IconButton(
           tooltip: state.showMedia ? context.l10n.hideMedia : context.l10n.showMedia,
           icon: Icon(state.showMedia ? Icons.filter_list_off : Icons.filter_list),
           onPressed: repo == null ? null : () => ctrl.toggleShowMedia(context.l10n),
         ),
          IconButton(
            tooltip: context.l10n.refresh,
            icon: const Icon(Icons.refresh),
            onPressed: repo == null ? null : () => ctrl.refresh(context.l10n),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (repo != null) {
            await ctrl.refresh(context.l10n);
          }
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (repo != null)
                     Card(
                       elevation: 0,
                       child: ExpansionTile(
                         title: Text(context.l10n.repositoryControls),
                         subtitle: Text(repo.alias?.isNotEmpty == true ? repo.alias! : repo.originalUrl,
                             maxLines: 1, overflow: TextOverflow.ellipsis),
                         children: [
                           _HeaderCard(
                             urlCtrl: _urlCtrl,
                             repo: repo,
                             sources: state.sources,
                             onBrowse: () => _handleBrowse(context, ctrl),
                             onAdd: () => _handleAddSource(context, ctrl),
                             onOpenSourcePicker: () => _showSourcePicker(context),
                             onClear: () {
                               _urlCtrl.clear();
                               ctrl.setUrl('', context.l10n);
                             },
                           ),
                         ],
                       ),
                     )
                   else
                     _HeaderCard(
                       urlCtrl: _urlCtrl,
                       repo: repo,
                       sources: state.sources,
                       onBrowse: () => _handleBrowse(context, ctrl),
                       onAdd: () => _handleAddSource(context, ctrl),
                       onOpenSourcePicker: () => _showSourcePicker(context),
                       onClear: () {
                         _urlCtrl.clear();
                         ctrl.setUrl('', context.l10n);
                       },
                     ),
                    const SizedBox(height: 12),
                    if (repo != null) ...[
                      _PathAndSearchBar(
                        theme: theme,
                        currentPath: state.currentPath,
                        canNavigateUp: state.currentPath.isNotEmpty,
                        searchCtrl: _searchCtrl,
                        onSearchChanged: (v) => ctrl.setSearch(v),
                        onNavigateUp: () => ctrl.navigateUp(context.l10n),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),

            // Listing
            SliverFillRemaining(
              hasScrollBody: true,
              child: repo == null
                  ? _EmptyRepoState(
                      onPasteExample: () {
                        _urlCtrl.text = 'https://github.com/aleff-github/my-flipper-shits';
                      },
                    )
                  : state.listing.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => _ErrorView(error: e.toString()),
                      data: (items) {
                        final q = state.searchQuery.trim().toLowerCase();
                        final filtered = q.isEmpty
                            ? items
                            : items.where((it) => it.name.toLowerCase().contains(q)).toList();

                        if (filtered.isEmpty) {
                          return const _EmptyList();
                        }

                        // Better scan UX: folders first, then files
                        final dirs = filtered.where((e) => e.type == RepoItemType.dir).toList();
                        final files = filtered.where((e) => e.type == RepoItemType.file).toList();

                        return ListView(
                          padding: const EdgeInsets.only(bottom: 16),
                          children: [
                            if (dirs.isNotEmpty) ...[
                              _SectionHeader(title: context.l10n.folders, count: dirs.length),
                              ...dirs.map(
                                (it) => _RepoItemTile(
                                  item: it,
                                  subtitle: it.path,
                                  onTap: () => ctrl.navigateInto(it, context.l10n),
                                ),
                              ),
                              const Divider(height: 16),
                            ],
                            if (files.isNotEmpty) ...[
                              _SectionHeader(title: context.l10n.files, count: files.length),
                              ...files.map(
                                (it) => _RepoItemTile(
                                  item: it,
                                  subtitle: it.path,
                                  trailing: _Badge(fileName: it.name),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => _FilePreviewScreen(itemPath: it.path),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBrowse(BuildContext context, PayloadsStoreController ctrl) async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pasteAGitHubURLFirst),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    ctrl.setUrl(url, context.l10n);
    FocusScope.of(context).unfocus();
  }

  Future<void> _handleAddSource(BuildContext context, PayloadsStoreController ctrl) async {
    final url = _urlCtrl.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pasteAGitHubURLFirst),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final parsed = parseGitHubUrl(url);
    if (parsed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.invalidGitHubURL),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await ctrl.addSource(parsed);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.sourceAdded),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _showSourcePicker(BuildContext context) async {
    final state = ref.read(payloadsStoreControllerProvider);
    final ctrl = ref.read(payloadsStoreControllerProvider.notifier);

    final sources = state.sources;
    if (sources.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.noSourcesSavedYet),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final chosen = await showModalBottomSheet<RepoRef>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.chooseSource,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: context.l10n.manage,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const ManageSourcesScreen()),
                        );
                      },
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: sources.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final r = sources[i];
                      final label = r.alias?.trim().isNotEmpty == true
                          ? r.alias!.trim()
                          : '${r.owner}/${r.repo}';
                      return ListTile(
                        leading: const Icon(Icons.source_outlined),
                        title: Text(label, overflow: TextOverflow.ellipsis),
                        subtitle: Text(
                          r.originalUrl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => Navigator.of(context).pop(r),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (chosen != null) {
      _urlCtrl.text = chosen.originalUrl;
      ctrl.setUrl(chosen.originalUrl, context.l10n);
    }
  }
}

class _HeaderCard extends StatelessWidget {
  final TextEditingController urlCtrl;
  final RepoRef? repo;
  final List<RepoRef> sources;
  final VoidCallback onBrowse;
  final VoidCallback onAdd;
  final VoidCallback onOpenSourcePicker;
  final VoidCallback onClear;

  const _HeaderCard({
    required this.urlCtrl,
    required this.repo,
    required this.sources,
    required this.onBrowse,
    required this.onAdd,
    required this.onOpenSourcePicker,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final repoLabel = repo == null
        ? context.l10n.noRepoSelected
        : (repo!.alias?.trim().isNotEmpty == true
            ? repo!.alias!.trim()
            : '${repo!.owner}/${repo!.repo}');

    final repoSub = repo == null ? context.l10n.pasteAURLBrowseThenImportPayloads : repo!.originalUrl;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.55),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storefront_outlined, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(repoLabel, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        repoSub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: context.l10n.pickFromSavedSources,
                  onPressed: sources.isEmpty ? null : onOpenSourcePicker,
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: urlCtrl,
              textInputAction: TextInputAction.go,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: 'GitHub URL',
                hintText: 'https://github.com/OWNER/REPO[/tree/BRANCH/path]',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.link),
                suffixIcon: IconButton(
                  tooltip: context.l10n.clear,
                  onPressed: onClear,
                  icon: const Icon(Icons.clear),
                ),
              ),
              onSubmitted: (_) => onBrowse(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onBrowse,
                    icon: const Icon(Icons.search),
                    label: Text(context.l10n.browse),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: Text(context.l10n.saveSource),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PathAndSearchBar extends StatelessWidget {
  final ThemeData theme;
  final String currentPath;
  final bool canNavigateUp;
  final TextEditingController searchCtrl;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onNavigateUp;

  const _PathAndSearchBar({
    required this.theme,
    required this.currentPath,
    required this.canNavigateUp,
    required this.searchCtrl,
    required this.onSearchChanged,
    required this.onNavigateUp,
  });

  @override
  Widget build(BuildContext context) {
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (currentPath.isNotEmpty)
          Row(
            children: [
              Icon(Icons.folder_open, size: 18, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  currentPath,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
              IconButton(
                tooltip: context.l10n.upOneFolder,
                onPressed: canNavigateUp ? onNavigateUp : null,
                icon: const Icon(Icons.arrow_upward),
              ),
            ],
          )
        else
          Row(
            children: [
              Icon(Icons.home_outlined, size: 18, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  context.l10n.repositoryRoot,
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
              IconButton(
                tooltip: context.l10n.upOneFolder,
                onPressed: null,
                icon: const Icon(Icons.arrow_upward),
              ),
            ],
          ),
        const SizedBox(height: 10),
        TextField(
          controller: searchCtrl,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: context.l10n.searchFilesAndFolders,
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}

class _RepoItemTile extends StatelessWidget {
  final RepoItem item;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _RepoItemTile({
    required this.item,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDir = item.type == RepoItemType.dir;
    final icon = isDir ? Icons.folder_outlined : Icons.description_outlined;

    return ListTile(
      leading: Icon(icon),
      title: Text(item.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;

  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Row(
        children: [
          Text(title, style: theme.textTheme.labelLarge),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String fileName;
  const _Badge({required this.fileName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final lower = fileName.toLowerCase();
    final dot = lower.lastIndexOf('.');
    final ext = dot >= 0 ? lower.substring(dot) : '';

    bool likelySupported = ext == '.json' || ext == '.txt' || ext == '.duck' || ext == '.ino';
    if (!likelySupported && ext.isEmpty) {
      // No extension: only hint importable if name contains script hints
      const hints = ['duck', 'payload', 'script'];
      likelySupported = hints.any((h) => lower.contains(h));
    }

    final widgets = <Widget>[];
    widgets.add(Text(likelySupported ? context.l10n.importable : context.l10n.notSupported, style: TextStyle(color: likelySupported ? Colors.green : cs.outline)));
    if (ext == '.ino') {
      widgets.add(const SizedBox(width: 6));
      widgets.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(context.l10n.converted, style: theme.textTheme.labelSmall?.copyWith(color: cs.onSecondaryContainer)),
      ));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }
}

class _EmptyRepoState extends StatelessWidget {
  final VoidCallback onPasteExample;
  const _EmptyRepoState({required this.onPasteExample});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.explore_outlined, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(context.l10n.browseAGitHubRepository, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              context.l10n.pasteARepoOrFolderURL,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onPasteExample,
              icon: const Icon(Icons.content_paste_outlined),
              label: Text(context.l10n.pasteExampleURL),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(context.l10n.noMatchingFilesOrFolders),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(context.l10n.failedToLoad, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(error, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _IssuesList extends StatelessWidget {
  final List<PreviewIssue> issues;
  const _IssuesList({required this.issues});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    const maxShow = 6;
    final toShow = issues.take(maxShow).toList();

    return Column(
      children: [
        for (final i in toShow)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  i.severity == 'error' ? Icons.error_outline : Icons.warning_amber_rounded,
                  size: 16,
                  color: i.severity == 'error' ? cs.error : cs.tertiary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    context.l10n.line(i.line.toString(), i.message),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (issues.length > maxShow)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              '+${issues.length - maxShow} ${context.l10n.moreThreePoints}',
              style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}

class _FilePreviewScreen extends ConsumerStatefulWidget {
  final String itemPath;
  const _FilePreviewScreen({required this.itemPath});

  @override
  ConsumerState<_FilePreviewScreen> createState() => _FilePreviewScreenState();
}

class _FilePreviewScreenState extends ConsumerState<_FilePreviewScreen> {
  bool _wrap = true;

  Widget _codeView(BuildContext context, String text, bool wrap) {
    final mono = const TextStyle(fontFamily: 'monospace');

    if (wrap) {
      return SingleChildScrollView(
        child: SelectableText(text, style: mono),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: SingleChildScrollView(
          child: SelectableText(text, style: mono),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(payloadsStoreControllerProvider);
    final repo = store.repo;

    if (repo == null) {
      return Scaffold(
        body: Center(child: Text(context.l10n.noRepositorySelected)),
      );
    }

    final svc = ref.read(githubStoreServiceProvider);

    return FutureBuilder<FilePreview>(
      future: svc.fetchFilePreview(repo, widget.itemPath, context.l10n),
      builder: (context, snap) {
        final theme = Theme.of(context);

        if (snap.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.itemPath.split('/').last)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snap.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.itemPath.split('/').last)),
            body: _ErrorView(error: snap.error.toString()),
          );
        }

        if (!snap.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.itemPath.split('/').last)),
            body: _ErrorView(error: context.l10n.noPreviewData),
          );
        }

        final preview = snap.data!;
        final hasOriginal = preview.originalText != null;
        final tabCount = hasOriginal ? 2 : 1;

        return DefaultTabController(
          length: tabCount,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.itemPath.split('/').last),
              bottom: hasOriginal
                  ? TabBar(
                      tabs: [
                        Tab(text: context.l10n.converted),
                        Tab(text: context.l10n.original),
                      ],
                    )
                  : null,
            ),
            body: Column(
              children: [
                if (preview.supportReason != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, size: 16, color: theme.colorScheme.tertiary),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            preview.supportReason!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Controls row: copy & wrap
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Row(
                    children: [
                      if (preview.wasConverted)
                        OutlinedButton.icon(
                          icon: const Icon(Icons.auto_awesome, size: 16),
                          label: Text(context.l10n.copyConverted),
                          onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: preview.text));
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(context.l10n.convertedCopied),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      if (preview.wasConverted && hasOriginal)
                        OutlinedButton.icon(
                          icon: const Icon(Icons.copy_all, size: 16),
                          label: Text(context.l10n.copyOriginal),
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: preview.originalText!));
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(context.l10n.originalCopied),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                        ),
                      const Spacer(),
                      IconButton(
                        tooltip: _wrap ? context.l10n.disableWrap : context.l10n.enableWrap,
                        onPressed: () => setState(() => _wrap = !_wrap),
                        icon: Icon(_wrap ? Icons.wrap_text : Icons.swap_horiz),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                    child: hasOriginal
                        ? TabBarView(
                            children: [
                              _codeView(context, preview.text, _wrap),
                              _codeView(context, preview.originalText!, _wrap),
                            ],
                          )
                        : _codeView(context, preview.text, _wrap),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (preview.issues.isNotEmpty) ...[
                        Text(context.l10n.validationSummary, style: theme.textTheme.labelLarge),
                        const SizedBox(height: 6),
                        _IssuesList(issues: preview.issues),
                        const SizedBox(height: 10),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: preview.isSupported
                                ? FilledButton.icon(
                                    icon: const Icon(Icons.download),
                                    label: Text(context.l10n.import),
                                    onPressed: () async {
                                      await _importPreview(context, ref, preview, repo);
                                    },
                                  )
                                : OutlinedButton.icon(
                                    onPressed: null,
                                    icon: const Icon(Icons.block),
                                    label: Text(context.l10n.notSupported),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _importPreview(
    BuildContext context,
    WidgetRef ref,
    FilePreview preview,
    RepoRef repo,
  ) async {
    try {
      if (preview.detectedFormat == DetectedFormat.payloadJson) {
        final obj = jsonDecode(preview.text) as Map<String, dynamic>;
        final payload = Payload.fromJson(obj);
        await ref.read(payloadsControllerProvider.notifier).importMany([payload]);
      } else if (preview.detectedFormat == DetectedFormat.ducky) {
        final name = preview.name.replaceAll(RegExp(r'\.[^.]+$'), '');
        final org = repo.owner;
        final repoName = repo.repo;
        final orgTag = (org.isNotEmpty ? org : repoName);
        final trimmed = orgTag.length <= 10 ? orgTag : orgTag.substring(0, 10);

        final draft = Payload(
          id: '',
          name: name.isEmpty ? context.l10n.importedDuckyScript : name,
          description: '${context.l10n.importedFrom(repo.owner, repo.repo)} • ${context.l10n.source(preview.name)}',
          script: preview.text,
          tags: [
            'imported',
            'github',
            trimmed,
            if (preview.wasConverted) 'ino',
          ],
          parameters: const [],
          isBuiltin: false,
        );

        await ref.read(payloadsControllerProvider.notifier).create(draft);
      } else {
        throw Exception(context.l10n.unsupportedFormat);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.importedSuccessfully),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.importFailed(e.toString())),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
