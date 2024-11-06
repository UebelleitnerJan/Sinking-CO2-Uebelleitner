//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "uebelleitnerTestApp.h"
#include "uebelleitnerApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
uebelleitnerTestApp::validParams()
{
  InputParameters params = uebelleitnerApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  return params;
}

uebelleitnerTestApp::uebelleitnerTestApp(InputParameters parameters) : MooseApp(parameters)
{
  uebelleitnerTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

uebelleitnerTestApp::~uebelleitnerTestApp() {}

void
uebelleitnerTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  uebelleitnerApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"uebelleitnerTestApp"});
    Registry::registerActionsTo(af, {"uebelleitnerTestApp"});
  }
}

void
uebelleitnerTestApp::registerApps()
{
  registerApp(uebelleitnerApp);
  registerApp(uebelleitnerTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
uebelleitnerTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  uebelleitnerTestApp::registerAll(f, af, s);
}
extern "C" void
uebelleitnerTestApp__registerApps()
{
  uebelleitnerTestApp::registerApps();
}
