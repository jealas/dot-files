#include "testqmlplugin_plugin.h"
#include "cppobject.h"

#include <qqml.h>

void TestqmlpluginPlugin::registerTypes(const char *uri)
{
    // @uri com.jesse
    qmlRegisterType<CppObject>(uri, 1, 0, "CppObject");
}

