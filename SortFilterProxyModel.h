#ifndef SORTFILTERPROXYMODEL_H
#define SORTFILTERPROXYMODEL_H

//#include <QAbstractItemModel>
#include <QSortFilterProxyModel>

class TreeNode {
public: 
    TreeNode(int row=-1, int column=-1, TreeNode *parent=0)
        : row(row), column(column), parent(parent)
    {   
//      if (parent)
//          parent->children.append(this);
    };  
    ~TreeNode()
    {
        qDeleteAll(children);
    }
    bool hasChildren()
    {
        return (children.count() != 0);
    }
    int row;
    int column;
    TreeNode *parent;
//  QModelIndex parentIdx;
    QList<TreeNode*> children;
    QList<QModelIndex> tableIdx;
    QString text;
};  

/* -------------------------------------------------------------------- */

// QTreeWidget

/**
 * @class SortFilterProxyModel
 * This derived class allows for multiple column filters.
 */
class SortFilterProxyModel : public QSortFilterProxyModel //QAbstractItemModel
{
    Q_OBJECT
public:
    explicit SortFilterProxyModel(QObject *parent = 0);
    ~SortFilterProxyModel();

    /** tree modeling capabilities **/
    void addChild(TreeNode *parent, TreeNode *child);
    void setSourceModel(QAbstractItemModel *sourceModel);

    QModelIndex mapToSource(const QModelIndex &proxyIndex) const;
//  QModelIndex mapFromSource(const QModelIndex &sourceIndex) const;

    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const;
    QModelIndex parent(const QModelIndex &child) const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    bool hasChildren(const QModelIndex &parent = QModelIndex()) const;

    QVariant data(const QModelIndex &proxyIndex, int role = Qt::DisplayRole) const;
    QVariant headerData(int section, Qt::Orientation orientation,
                        int role = Qt::DisplayRole) const;

    /** filtering capabilities **/
    void setFilter(int column, const QString &pattern);
    QString filterAt(int column);
    void clearFilters();
    void refreshFilters();

protected:
    bool filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const;

private:
    int addChildCount;
//  struct node_t { QString rid; QString pid; QModelIndex idx; };
//  QList<node_t> nodes;

    TreeNode *nodeFromItem(TreeNode *parent, int column, QString value) const;
    TreeNode *nodeFromIndex(const QModelIndex &index) const;

    TreeNode *rootNode;
    QList<QList<TreeNode*> > tableNodes;

    QMap<int, QRegExp> m_columnPatterns;
};

#endif // SORTFILTERPROXYMODEL_H
