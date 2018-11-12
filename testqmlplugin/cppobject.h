#ifndef CPPOBJECT_H
#define CPPOBJECT_H

#include <QQuickItem>

class CppObject : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(CppObject)

public:
    CppObject(QQuickItem *parent = nullptr);
    ~CppObject();
};

#endif // CPPOBJECT_H
