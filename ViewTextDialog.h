#ifndef _ViewTextDialog_h_
#define _ViewTextDialog_h_

#include <QtCore/QString>
#include <QtWidgets/QDialog>

#include "ui_ViewTextDialog.h"

/**
 * @class ViewTextDialog
 * Provides a monospaced view of text.
 */
class ViewTextDialog : public QDialog, public Ui::Ui_ViewTextDialog
{
    Q_OBJECT

public:
    ViewTextDialog(QWidget * parent = 0);
    ~ViewTextDialog() {}

    void setContents(const QString *text);
};

#endif
