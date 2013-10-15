#include <QDebug>
#include <QtSql/QSqlQuery>
#include <QSqlTableModel>

#include <iostream>
#include "SortFilterProxyModel.h"
#include "calTableHeaders.h"

/* -------------------------------------------------------------------- */

SortFilterProxyModel::SortFilterProxyModel(QObject *parent)
  : QSortFilterProxyModel(parent) //QAbstractItemModel(parent)
{
    rootNode = new TreeNode;
    qDebug() << __PRETTY_FUNCTION__ << "rootNode:" << rootNode;
    addChildCount = 0; // DEBUG
}

/* -------------------------------------------------------------------- */

SortFilterProxyModel::~SortFilterProxyModel()
{
//  delete rootNode;
}

/* -------------------------------------------------------------------- */

// The nodeFromItem() function recursively searches the tree model for the
// given value in the specified column, or returns the root node if nothing is
// found, since an invalid model index is used to represent the root in a
// model.
// NEW

TreeNode *SortFilterProxyModel::nodeFromItem(TreeNode *parent, int column, QString value) const
{
    qDebug() << __PRETTY_FUNCTION__ << "parent:" << parent << "column:" << column << "value:" << value << " parent->children.size():" << parent->children.size();

// This needs some work...
// We need to exit out of recursion if the parent itself matches the searched value.
// Also passing in the column number is superfluous because this function is currently only being used to find a matching parent.
// Only column 0 (the RID) is needed for this.

    if ( !parent->hasChildren() )
        return rootNode;

    QList<TreeNode*>::iterator child = parent->children.begin();

    while( child != parent->children.end() ) {

        QModelIndex qmi = (*child)->tableIdx[column];
        qDebug() << __PRETTY_FUNCTION__ << "*child:" << *child << " sourceModel()->data(qmi):" << sourceModel()->data(qmi).toString().trimmed();

        if ( sourceModel()->data(qmi).toString().trimmed() == value )
            return (*child);

//      if ( (*child)->hasChildren() ) {
//          qDebug() << __PRETTY_FUNCTION__ << "RECURSING";
//          return nodeFromItem((*child), column, value);
//      }
        child++;
    }
    return rootNode;
}

/* -------------------------------------------------------------------- */

// The nodeFromIndex() function casts the given index's void * to a TreeNode *, or
// returns the root node if the index is invalid, since an invalid model index
// is used to represent the root in a model.
//ORIG
TreeNode *SortFilterProxyModel::nodeFromIndex(const QModelIndex &index) const
{
    if (index.isValid()) {
        return static_cast<TreeNode *>(index.internalPointer());
    } else {
        return rootNode;
    }
}

/* -------------------------------------------------------------------- */

void SortFilterProxyModel::addChild(TreeNode *parent, TreeNode *child)
{
    qDebug() << __PRETTY_FUNCTION__ << "parent: " << parent << " child: " << child;

    QString p_rid = "p_rid";
    QString c_rid = "c_rid";

    if (parent != rootNode)
        p_rid = parent->tableIdx[clm_rid].data().toString().trimmed();

    c_rid =  child->tableIdx[clm_rid].data().toString().trimmed();
    qDebug() << __PRETTY_FUNCTION__ << "p_rid: " << p_rid << " c_rid: " << c_rid;

    addChildCount++;
//  if (child) {
        parent->children += child;
        child->parent = parent;
//  }
}

/* -------------------------------------------------------------------- */

// Reindex the table source model into a tree model.

void SortFilterProxyModel::setSourceModel(QAbstractItemModel *sourceModel)
{
    qDebug() << __PRETTY_FUNCTION__;
    QSortFilterProxyModel::setSourceModel(sourceModel);

    qDebug() << __PRETTY_FUNCTION__ << "sourceModel:" << sourceModel;
//  qDebug() << "sourceModel->query().lastQuery():" << sourceModel->query().lastQuery();
    qDebug() << "sourceModel->rowCount():" << sourceModel->rowCount();
    qDebug() << "sourceModel->columnCount():" << sourceModel->columnCount();
//  qDebug() << "sourceModel->canFetchMore():" << sourceModel->canFetchMore();

    QString rid;
    QString pid;
    QString date;

    QList<TreeNode*> orphanage;

    // Assign children to parents, note that unassigned children will be placed
    // into an orphanage for processing later.
    for (int row=0; row < sourceModel->rowCount(); row++) {

        rid = sourceModel->index(row, clm_rid).data().toString().trimmed();
        pid = sourceModel->index(row, clm_pid).data().toString().trimmed();
        date = sourceModel->index(row, clm_cal_date).data().toString().trimmed(); // DEBUG

        // create a new row in the tree model
        TreeNode* aRow = new TreeNode();
        qDebug() << __PRETTY_FUNCTION__ << " aRow:" << aRow << "rid:" << rid << " pid:" << pid << " date:" << date;
//      aRow->parentIdx = sourceModel->index(row, 0);

        for (int column = 0; column < sourceModel->columnCount(); column++)
        {
            aRow->tableIdx.append( sourceModel->index(row, column) );

            if (rootNode->children.size() > 2845)
                qDebug() << "row:" << row << "column:" << column << "QMI:" << sourceModel->index(row, column)
                         << " value:" << sourceModel->data(aRow->tableIdx.last()).toString().trimmed();
        }
        if (pid.length() == 0) {

            // no parent, insert row as a root item
            addChild( rootNode, aRow );

        } else {

            // has parent, find it...
            qDebug() << "AAA rootNode->children.size():" << rootNode->children.size();
            TreeNode* iNode = nodeFromItem(rootNode, clm_rid, pid);
            qDebug() << "BBB rootNode->children.size():" << rootNode->children.size();

            if ( (iNode != rootNode) &&
                 (iNode->tableIdx[clm_rid].data().toString().trimmed()) == pid) {
                qDebug() << "found parent:" << pid << " iNode:" << iNode << " for aRow:" << aRow;

    QString p_rid = iNode->tableIdx[clm_rid].data().toString().trimmed();
    QString c_rid =  aRow->tableIdx[clm_rid].data().toString().trimmed();
    qDebug() << __PRETTY_FUNCTION__ << "PPP p_rid: " << p_rid << " c_rid: " << c_rid;
    qDebug() << __PRETTY_FUNCTION__ << "PPP iNode: " << iNode << " aRow: " << aRow;

                // insert row as a child of it
                addChild( iNode, aRow );
//              addChild( rootNode, aRow );
            }
            // has no parent, place into iNode orphange
            else {
                qDebug() << "found iNode orphan:" << rid;
                orphanage.append( aRow );
            }
            qDebug() << __PRETTY_FUNCTION__ << "aRow:    " << aRow;
        }
    } 
/*
 */
    qDebug() << "before N addChildCount:" << addChildCount;
    qDebug() << "before N rowCount():" << rowCount();
    qDebug() << "before N orphanage:" << orphanage.count();

    // Assign orphans to parents.
    while ( !orphanage.isEmpty() ) {

        QList<TreeNode*>::iterator orphan = orphanage.begin();

        while ( orphan != orphanage.end() ) {

            pid = (*orphan)->tableIdx[clm_pid].data().toString().trimmed();
            qDebug() << "orphan's PID:" << pid;

            TreeNode* iNode = nodeFromItem(rootNode, clm_rid, pid);

            if ( (iNode != rootNode) &&
                 (iNode->tableIdx[clm_rid].data().toString().trimmed()) == pid) {

                qDebug() << "found orphan's parent: " << pid;
                // insert row as a child of it
                addChild( iNode, *orphan );
                orphan = orphanage.erase(orphan);
            }
            else
                orphan++;
        }
    }
    qDebug() << "after N addChildCount:" << addChildCount;
    qDebug() << "after N rowCount():" << rowCount();
    qDebug() << "after N orphanage:" << orphanage.count();

    qDebug() << "sourceModel->rowCount():" << sourceModel->rowCount();
    qDebug() << "sourceModel->columnCount():" << sourceModel->columnCount();
}

/* -------------------------------------------------------------------- */

#if 0
// The mapFromSource() function ...
//NEW
QModelIndex SortFilterProxyModel::mapFromSource(const QModelIndex &sourceIndex) const
{   
    qDebug() << __PRETTY_FUNCTION__ << "sourceIndex:" << sourceIndex;
    TreeNode *node = tableNodes.at(sourceIndex.column()).at(sourceIndex.row());
    Q_ASSERT(node);
    if (!node)
        return QModelIndex();
            
    Q_ASSERT(false);
    return index(sourceIndex.row(), 0);
    return QSortFilterProxyModel::mapFromSource(sourceIndex);
}               
#endif
/* -------------------------------------------------------------------- */

// The mapToSource() function ...
//NEW
QModelIndex SortFilterProxyModel::mapToSource(const QModelIndex &proxyIndex) const
{
//  qDebug() << __PRETTY_FUNCTION__ << "proxyIndex:" << proxyIndex;

    if (!proxyIndex.isValid())
        return QModelIndex();
    
    const TreeNode *node = static_cast<TreeNode*>(proxyIndex.internalPointer());
    Q_ASSERT(node);
    if (!node) 
        return QModelIndex();
    
//  qDebug() << __PRETTY_FUNCTION__ << "node:" << node << "row:" << node->row << "column:"
//    << node->column << "parent:" << node->parent << "nChildren:" << node->children.count()
//    << "ntableIdx:" << node->tableIdx.count();
//  qDebug() << __PRETTY_FUNCTION__ << "returns:" << node->tableIdx[proxyIndex.column()];
    return node->tableIdx[proxyIndex.column()];
}

/* -------------------------------------------------------------------- */

// The index() function is reimplemented from QAbstractItemModel. It is called
// whenever the model or the view needs to create a QModelIndex for a
// particular child item (or a top-level item if parent is an invalid
// QModelIndex). For table and list models, we don't need to reimplement this
// function, because QAbstractListModel's and QAbstractTableModel's default
// implementations normally suffice.
//
// In our index() implementation, if no parse tree is set, we return an invalid
// QModelIndex. Otherwise, we create a QModelIndex with the given row and
// column and with a TreeNode * for the requested child. For hierarchical models,
// knowing the row and column of an item relative to its parent is not enough
// to uniquely identify it; we must also know who its parent is. To solve this,
// we can store a pointer to the internal node in the QModelIndex. QModelIndex
// gives us the option of storing a void * or an int in addition to the row and
// column numbers.
//
// The TreeNode * for the child is obtained through the parent node's children
// list. The parent node is extracted from the parent model index using the
// nodeFromIndex() private function:
// ORIG
QModelIndex SortFilterProxyModel::index(int row, int column,
                                const QModelIndex &parent) const
{
    if (!rootNode || row < 0 || column < 0)
        return QModelIndex();
    TreeNode *parentNode = nodeFromIndex(parent);
    TreeNode *childNode = parentNode->children.value(row);
    if (!childNode)
        return QModelIndex();
    return createIndex(row, column, childNode);
}

/* -------------------------------------------------------------------- */

// The number of rows for a given item is simply how many children it has.
// ORIG
int SortFilterProxyModel::rowCount(const QModelIndex &parent) const
{
    if (parent.column() > 0)
        return 0;
    TreeNode *parentNode = nodeFromIndex(parent);
    if (!parentNode)
        return 0;
    return parentNode->children.count();
}

/* -------------------------------------------------------------------- */

// The number of columns is fixed at 1 less than total number of columns
// in the SQL table.  The first column holds the RID tree, the remaining
// columns hold the SQL table values.
// ALTERED... IS THIS NEEDED?
int SortFilterProxyModel::columnCount(const QModelIndex & /* parent */) const
{
    return sourceModel()->columnCount(); // clm_COUNT;
}

/* -------------------------------------------------------------------- */

// The hasChildren() function ...
//NEW
bool SortFilterProxyModel::hasChildren(const QModelIndex &parent /* = QModelIndex() */) const
{
    const TreeNode *node = static_cast<TreeNode*>(parent.internalPointer());
    if (!node)
        node = rootNode;
        
    return node->children.size() > 0;
#if 0
    // TODO: Horrible, horrible hack but works in the short term
    return !parent.parent().isValid();
#endif

#if 0
    qDebug() << __PRETTY_FUNCTION__ << "parent:" << parent;
    TreeNode *cast_parent = static_cast<TreeNode *>(parent.internalPointer());
    qDebug() << __PRETTY_FUNCTION__ << "cast parent:" << cast_parent;
    return QSortFilterProxyModel::hasChildren(parent);
#endif
}

/* -------------------------------------------------------------------- */

// Retrieving the parent QModelIndex from a child is a bit more work than
// finding a parent's child. We can easily retrieve the parent node using
// nodeFromIndex() and going up using the TreeNode's parent pointer, but to obtain
// the row number (the position of the parent among its siblings), we need to
// go back to the grandparent and find the parent's index position in its
// parent's (i.e., the child's grandparent's) list of children.
// ORIG
QModelIndex SortFilterProxyModel::parent(const QModelIndex &child) const
{
    TreeNode *node = nodeFromIndex(child);
    if (!node)
        return QModelIndex();
    TreeNode *parentNode = node->parent;
    if (!parentNode)
        return QModelIndex();
    TreeNode *grandparentNode = parentNode->parent;
    if (!grandparentNode)
        return QModelIndex();

    int row = grandparentNode->children.indexOf(parentNode);
    return createIndex(row, 0, parentNode);
}

/* -------------------------------------------------------------------- */

// In data(), we retrieve the TreeNode * for the requested item and we use it to
// access the underlying data. If the caller wants a value for any role except
// Qt::DisplayRole or if we cannot retrieve a TreeNode for the given model index,
// we return an invalid QVariant. If the column is 0, we return the name of the
// node's type; if the column is 1, we return the node's value (its string).
// ALTERED
QVariant SortFilterProxyModel::data(const QModelIndex& proxyIndex, const int role) const
{
    return sourceModel()->data(mapToSource(proxyIndex), role);
}
/*
QVariant SortFilterProxyModel::data(const QModelIndex &proxyIndex, int role) const
{
//  qDebug() << __PRETTY_FUNCTION__ << "proxyIndex:" << proxyIndex  << "role:" << role;
//  if (role != Qt::DisplayRole)
//      qDebug() << __PRETTY_FUNCTION__ << sourceModel()->index( proxyIndex.row(), proxyIndex.column() ).data();
    if (role != Qt::DisplayRole)
        return QVariant();
        return sourceModel()->index( proxyIndex.row(), proxyIndex.column() ).data();
#if 0
    TreeNode *node = nodeFromIndex(index);
    if (!node)
        return QVariant();

    if (index.column() == 0) {
        switch (node->type) {
        case TreeNode::Root:
             return tr("Root");
        case TreeNode::OrExpression:
            return tr("OR Expression");
        case TreeNode::AndExpression:
            return tr("AND Expression");
        case TreeNode::NotExpression:
            return tr("NOT Expression");
        case TreeNode::Atom:
            return tr("Atom");
        case TreeNode::Identifier:
            return tr("Identifier");
        case TreeNode::Operator:
            return tr("Operator");
        case TreeNode::Punctuator:
            return tr("Punctuator");
        default:
            return tr("Unknown");
        }
    } else if (index.column() == 1) {
        return node->str;
    }
#endif
    return QVariant();
}
*/
/* -------------------------------------------------------------------- */

// In our headerData() reimplementation, we return appropriate horizontal
// header labels. The QTreeView class, which is used to visualize hierarchical
// models, has no vertical header, so we ignore that possibility.
// ALTERED
QVariant SortFilterProxyModel::headerData(int section,
                                  Qt::Orientation orientation,
                                  int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole) {
//      qDebug() << "headerData: " << sourceModel()->headerData(section, Qt::Horizontal);
        return sourceModel()->headerData(section, Qt::Horizontal);
    }
    return QVariant();
}

/* -------------------------------------------------------------------- */

void SortFilterProxyModel::setFilter(int column, const QString &pattern)
{
    qDebug() << __PRETTY_FUNCTION__ << "column:" << column  << "pattern:" << pattern;

    if (pattern.isEmpty())
        m_columnPatterns.remove(column);
    else
        m_columnPatterns[column] = QRegExp(pattern, Qt::CaseInsensitive);

    invalidateFilter();
}

/* -------------------------------------------------------------------- */

QString SortFilterProxyModel::filterAt(int column)
{
    if (m_columnPatterns.contains(column))
        return m_columnPatterns[column].pattern();
    else
        return "";
}

/* -------------------------------------------------------------------- */

void SortFilterProxyModel::clearFilters()
{
    if(m_columnPatterns.isEmpty())
        return;

    qDebug() << __PRETTY_FUNCTION__;
    m_columnPatterns.clear();
    invalidateFilter();
}

/* -------------------------------------------------------------------- */

void SortFilterProxyModel::refreshFilters()
{
    invalidateFilter();
}

/* -------------------------------------------------------------------- */

bool SortFilterProxyModel::filterAcceptsRow(int sourceRow, 
  const QModelIndex &sourceParent) const
{
    if(m_columnPatterns.isEmpty())
        return true;

    bool ret = false;

    for(QMap<int, QRegExp>::const_iterator iter = m_columnPatterns.constBegin();
        iter != m_columnPatterns.constEnd(); ++iter)
    {
        QModelIndex index = sourceModel()->index(sourceRow, iter.key(), sourceParent);
        ret = index.data().toString().contains(iter.value());

        if(!ret)
            return ret;
    }

    return ret;
}
