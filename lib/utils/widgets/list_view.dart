import 'package:flutter/material.dart';

class ListViewLoadMoreAndRefresh<T> extends StatefulWidget {
  final Widget Function(T item, int index) item;
  final Function() onRefresh;
  final Function() onLoadMore;
  final List<T?> list;
  final Widget? loadMoreWidget;

  ListViewLoadMoreAndRefresh(
      {required this.item, required this.onLoadMore, required this.onRefresh, required this.list, this.loadMoreWidget});

  @override
  _ListViewLoadMoreAndRefreshState<T> createState() =>
      _ListViewLoadMoreAndRefreshState<T>();
}

class _ListViewLoadMoreAndRefreshState<T>
    extends State<ListViewLoadMoreAndRefresh<T>> {
  bool isLoadMore = false;
  static const offsetVisibleThreshold = 50;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if ((_scrollController.offset + offsetVisibleThreshold >=
          _scrollController.position.maxScrollExtent) &&
          !isLoadMore) {
        isLoadMore = true;
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.last != null) {
      isLoadMore = false;
    }
    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh();
      },
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (widget.list[index] == null) {
            return widget.loadMoreWidget ?? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    child: CircularProgressIndicator(strokeWidth: 2),
                    height: 23.0,
                    width: 23.0,
                  ),
                )
              ],
            );
          }
          return widget.item(widget.list[index]!, index);
        },
        itemCount: widget.list.length,
      ),
    );
  }
}

class ListViewLoadMore extends StatefulWidget {
  final Widget Function(dynamic item, int index) item;
  final Function() onLoadMore;
  final List list;
  final bool isReverse;
  final scrollController;

  ListViewLoadMore(
      {required this.item, required this.onLoadMore, required this.list, this.isReverse = false, this.scrollController});

  @override
  _ListViewLoadMoreState createState() =>
      _ListViewLoadMoreState();
}

class _ListViewLoadMoreState extends State<ListViewLoadMore> {
  bool isLoadMore = false;
  static const offsetVisibleThreshold = 50;
  var _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(() {
      if ((_scrollController.offset + offsetVisibleThreshold >=
          _scrollController.position.maxScrollExtent) &&
          !isLoadMore) {
        isLoadMore = true;
        widget.onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.last != null) {
      isLoadMore = false;
    }
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => widget.item(widget.list[index], index),
      itemCount: widget.list.length,
      reverse: widget.isReverse,
    );
  }
}
