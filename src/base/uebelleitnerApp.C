#include "uebelleitnerApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
uebelleitnerApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

uebelleitnerApp::uebelleitnerApp(InputParameters parameters) : MooseApp(parameters)
{
  uebelleitnerApp::registerAll(_factory, _action_factory, _syntax);
}

uebelleitnerApp::~uebelleitnerApp() {}

void 
uebelleitnerApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<uebelleitnerApp>(f, af, s);
  Registry::registerObjectsTo(f, {"uebelleitnerApp"});
  Registry::registerActionsTo(af, {"uebelleitnerApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
uebelleitnerApp::registerApps()
{
  registerApp(uebelleitnerApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
uebelleitnerApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  uebelleitnerApp::registerAll(f, af, s);
}
extern "C" void
uebelleitnerApp__registerApps()
{
  uebelleitnerApp::registerApps();
}
