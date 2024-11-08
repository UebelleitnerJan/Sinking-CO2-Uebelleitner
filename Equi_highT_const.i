[Mesh]
  [file] # Input File in order to reach pressure equilibrium after 1000 years
    type = FileMeshGenerator
    file = 'task_2D_new.msh' # 800m width, 1050m depth
  []
[]

[GlobalParams]
  PorousFlowDictator = dictator
  # gravity = '0 -9.81 0'
[]

[Variables]
  [pres_water]
    initial_condition = 34e6
  []
#  [sgas]
#    initial_condition = 0.0
#  []
   [temp]
    initial_condition = 773.15
    scaling = 1E-6 # fluid enthalpy is roughly 1E6
  []
[]
[AuxVariables]
  [massfrac_ph0_sp0]
    initial_condition = 1
  []
#  [massfrac_ph1_sp0]
#    initial_condition = 0
#  []
  [massfrac_ph0_sp1]
  []
#  [massfrac_ph1_sp1]
#  []
#  [pgas]
#    family = MONOMIAL
#    order = FIRST
#  []
  [swater]
    family = MONOMIAL
    order = FIRST
  []
  [./density_water]
    order = CONSTANT
    family = MONOMIAL
  [../]
#  [./density_gas]
#    order = CONSTANT
#    family = MONOMIAL
#  [../]
  [./viscosity_water]
    order = CONSTANT
    family = MONOMIAL
  [../]
#  [./viscosity_gas]
#    order = CONSTANT
#    family = MONOMIAL
# [../]
#  [./enthalpy_gas]
#    order = CONSTANT
#    family = MONOMIAL
#  [../]
  [./enthalpy_water]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [bulk_vel_x]
    order = CONSTANT
    family = MONOMIAL
  []
  [bulk_vel_y]
    order = CONSTANT
    family = MONOMIAL
  []
  [bulk_vel_z]
    order = CONSTANT
    family = MONOMIAL
  []  
[]

[Kernels]
#  [mass_water_dot]
#    type = PorousFlowMassTimeDerivative
#    fluid_component = 0
#    variable = pres_water
# []
  [flux_water]
    type = PorousFlowAdvectiveFlux
    fluid_component = 0
    variable = pres_water
    gravity = '0 -9.81 0' # adding gravity for water and CO2 
  []
#  [mass_co2_dot]
#    type = PorousFlowMassTimeDerivative
#    fluid_component = 1
#    variable = sgas
#  []
#  [flux_co2]
#    type = PorousFlowAdvectiveFlux
#    fluid_component = 1
#    variable = sgas
#    gravity = '0 -9.81 0'
#  []
#  [energy_dot]
#    type = PorousFlowEnergyTimeDerivative
#    variable = temp
#  []

  [heat_advection]
    type = PorousFlowHeatAdvection
    variable = temp
    gravity = '0 -9.81 0'
  []
  [conduction]
    type = PorousFlowHeatConduction
    variable = temp
  []
# [specific_heat]
#   type = SpecificHeatConductionTimeDerivative
#   variable = temp
#  []  
[]

[AuxKernels]
#  [pgas]
#    type = PorousFlowPropertyAux
#    property = pressure
#    phase = 1
#    variable = pgas
#  []
  [swater]
    type = PorousFlowPropertyAux
    property = saturation
    phase = 0
    variable = swater
  []
#  [./enthalpy_gas]
#    type = PorousFlowPropertyAux
#    property = enthalpy
#    phase = 1
#    variable = enthalpy_gas
#  [../]
  [./enthalpy_water]
    type = PorousFlowPropertyAux
    property = enthalpy
    phase = 0
    variable = enthalpy_water
  [../]
  [./density_water]
    type = PorousFlowPropertyAux
    property = density
    phase = 0
    variable = density_water
  [../]
#  [./density_gas]
#    type = PorousFlowPropertyAux
#    variable = density_gas
#    phase = 1
#    property = density
#  [../]
  [./viscosity_water]
    type = PorousFlowPropertyAux
    property = viscosity
    phase = 0
    variable = viscosity_water
  [../]
#  [./viscosity_gas]
#    type = PorousFlowPropertyAux
#    property = viscosity
#    phase = 1
#    variable = viscosity_gas
#  [../]
  [bulk_vel_x]
    type = PorousFlowDarcyVelocityComponent
    variable = bulk_vel_x
    component = x
    fluid_phase = 0
    gravity = '0 -9.81 0'
  []
  [bulk_vel_y]
    type = PorousFlowDarcyVelocityComponent
    variable = bulk_vel_y
    component = y
    fluid_phase = 0
    gravity = '0 -9.81 0'
  []
  [bulk_vel_z]
    type = PorousFlowDarcyVelocityComponent
    variable = bulk_vel_z
    component = z
    fluid_phase = 0
    gravity = '0 -9.81 0'
  []
[]

[BCs]
  [top_pressure]
    type = DirichletBC
    variable = pres_water
    value = 31e6
    boundary = 'TopBC'
 []
#   [side_pressure]
#    type = DirichletBC
#    variable = pres_water
#    value = 31e6
#    boundary = 'LeftBC'
#  []  
#  [magma_temperature]
#    type = DirichletBC
#    variable = temp
#    value = 900
#    boundary = 'Magma'
# []
  [top_temperature]
    type = DirichletBC
    variable = temp
    value = 773.15
    boundary = 'TopBC'
 []
# [./BottomBC]
#   type = ConvectiveHeatFluxBC
#   variable = temp
#   boundary = 'BottomBC'
#   T_infinity = 900
#   heat_transfer_coefficient = 10
#   heat_transfer_coefficient_dT = 0
# [../]
 
#  [injection_temperature]
#    type = DirichletBC
#    variable = temp
#    value = 773.15
#    boundary = 'InjectionPoint'
#  []
[]

#[DiracKernels] # Point source and point sink code/elements
#  [fluid_injection]
#    point = '800 525 0'
#    mass_flux = 0
#    variable = sgas
#    type = PorousFlowSquarePulsePointSource
#  []
  #[fluid_production]
   # type = PorousFlowPeacemanBorehole
   # variable = pres_water
   # SumQuantityUO = produced_mass_h2o
   # point_file = 'well_out.bh'
   # function_of = pressure
   # fluid_phase = 0
   # bottom_p_or_t = 24E6
   # unit_weight = '0 0 0'
   # use_mobility = true
   # character = 1
   # line_direction = '0 0 1'
   # line_length = 1
  #[]
  #[co2_production]
   # type = PorousFlowPeacemanBorehole
   # variable = sgas
   # SumQuantityUO = produced_mass_co2
   # point_file = 'well_out.bh'
   # function_of = pressure
   # fluid_phase = 1
   # bottom_p_or_t = 24E6
   # unit_weight = '0 0 0'
   # use_mobility = true
   # character = 1
   # line_direction = '0 0 1'
   # line_length = 1
  #[]
  #[remove_heat_at_production_well_h2o]
   # type = PorousFlowPeacemanBorehole
   # variable = temp
   # SumQuantityUO = produced_heat_h2o
   # point_file = 'well_out.bh'
   # function_of = pressure
   # fluid_phase = 0
   # bottom_p_or_t = 24E6
   # unit_weight = '0 0 0'
   # use_mobility = true
   # use_enthalpy = true
   # character = 1
   # line_direction = '0 0 1'
   # line_length = 1
  #[]
  #[remove_heat_at_production_well_co2]
   # type = PorousFlowPeacemanBorehole
   # variable = temp
   # SumQuantityUO = produced_heat_co2
   # point_file = 'well_out.bh'
   # function_of = pressure
   # fluid_phase = 1
   # bottom_p_or_t = 24E6
   # unit_weight = '0 0 0'
   # use_mobility = true
   # use_enthalpy = true
   # character = 1
   # line_direction = '0 0 1'
   # line_length = 1
  #[]
#[]

[UserObjects]
  [produced_mass_h2o]
    type = PorousFlowSumQuantity
  []
#  [produced_mass_co2]
#    type = PorousFlowSumQuantity
#  []
  [produced_heat_h2o]
    type = PorousFlowSumQuantity
  []
#  [produced_heat_co2]
#    type = PorousFlowSumQuantity
#  []
  [dictator]
    type = PorousFlowDictator
    porous_flow_vars = 'temp pres_water'
    number_fluid_phases = 1 
    number_fluid_components = 1 
  []
  [pc]
    type = PorousFlowCapillaryPressureConst
    pc = 0
  []
[]
[Postprocessors]
  [heat_joules_extracted_this_timestep_h2o]
    type = PorousFlowPlotQuantity
    uo = produced_heat_h2o
    outputs = csv
  []
#  [heat_joules_extracted_this_timestep_co2]
#    type = PorousFlowPlotQuantity
#    uo = produced_heat_co2
#    outputs = csv
#  []
  [mass_kg_h2o_extracted_this_timestep]
    type = PorousFlowPlotQuantity
    uo = produced_mass_h2o
    outputs = csv
  []
#  [mass_kg_co2_extracted_this_timestep]
#    type = PorousFlowPlotQuantity
#    uo = produced_mass_co2
#    outputs = csv
#  []
#  [Sg]
#    type = PointValue
#    point = '0 525 0'
#    variable = sgas
#  []
  [Sw]
    type = PointValue
    point = '0 525 0'
    variable = swater
  []
#  [rhog]
#    type = PointValue
#    point = '0 525 0'
#    variable = density_gas
#  []
  [rhow]
    type = PointValue
    point = '0 525 0'
    variable = density_water
  []
  [temperature]
    type = PointValue
    point = '0 525 0'
    variable = temp
  []
  [temperature_injection_point]
    type = PointValue
    point = '800 525 0'
    variable = temp
  []
  [temperature_middle]
    type = PointValue
    point = '400 525 0'
    variable = temp
  []  
  [mu_w]
    type = PointValue
    point = '0 525 0'
    variable = viscosity_water
  []
#  [mu_g]
#    type = PointValue
#    point = '0 525 0'
#    variable = viscosity_gas
#  []
  [h_w]
    type = PointValue
    point = '0 525 0'
    variable = enthalpy_water
  []
#  [h_g]
#    type = PointValue
#    point = '0 525 0'
#    variable = enthalpy_gas
#  []
  [pressure_injection_point]
    type = PointValue
    point = '800 525 0'
    variable = pres_water
  []
  [pressure_prod_point]
    type = PointValue
    point = '0 525 0'
    variable = pres_water
  [] 
  [pressure_middle]
    type = PointValue
    point = '400 525 0'
    variable = pres_water
  [] 
  [bulk_vel_x]
    type = ElementAverageValue
    block = 25
    variable = bulk_vel_x
  []
  [bulk_vel_y]
    type = ElementAverageValue
    block = 25
    variable = bulk_vel_y
  []
  [bulk_vel_z]
    type = ElementAverageValue
    block = 25
    variable = bulk_vel_z
  []
[]
#[Modules]
  [FluidProperties]
    [./water]
      type = Water97FluidProperties
    [../]
    [./co2]
      type = CO2FluidProperties
    [../]
  []
#[]

[Materials]
  [temperature]
    type = PorousFlowTemperature
    temperature = temp
  []
  [ppss]
    type = PorousFlow1PhaseFullySaturated
    porepressure = pres_water
   # phase1_saturation = sgas
   # capillary_pressure = pc
  []
  [massfrac]
    type = PorousFlowMassFraction

  []
  [water]
    type = PorousFlowSingleComponentFluid
    fp = water
    phase = 0
  []
#  [gas]
#    type = PorousFlowSingleComponentFluid
#    fp = co2
#    phase = 1
#  []
  [relperm_liquid]
    type = PorousFlowRelativePermeabilityCorey
    n = 2
    phase = 0
    s_res = 0.1
    sum_s_res = 0.1
  []
 # [relperm_gas]
 #   type = PorousFlowRelativePermeabilityCorey
 #   n = 2
 #   phase = 1
 # []
  [porosity]
    type = PorousFlowPorosityConst # only the initial value of this is ever used
    porosity = 0.15
  []
  [biot_modulus]
    type = PorousFlowConstantBiotModulus
    solid_bulk_compliance = 1E-10
    fluid_bulk_modulus = 2E9
  []
  [permeability]
    type = PorousFlowPermeabilityConst
    permeability = '1e-16 0 0   0 1e-16 0   0 0 1e-16'
  []
  [thermal_expansion]
    type = PorousFlowConstantThermalExpansionCoefficient
    fluid_coefficient = 5E-6
    drained_coefficient = 2E-4
  []
  [thermal_conductivity]
    type = PorousFlowThermalConductivityIdeal
    dry_thermal_conductivity = '1 0 0  0 1. 0  0 0 1'
    wet_thermal_conductivity = '3 0 0  0 3. 0  0 0 3'
  []
  [rock_heat]
    type = PorousFlowMatrixInternalEnergy
    density = 2500.0
    specific_heat_capacity = 1200.0
  []
  [./constant]
    type = HeatConductionMaterial
    block = 25
    thermal_conductivity = 4
    specific_heat = 1
  [../]
  [./density]
    type = GenericConstantMaterial
    block = 25
    prop_names = density
    prop_values = 2500
  [../]    
[]

[Preconditioning]
  active = preferred_but_might_not_be_installed
  [basic]
    type = SMP
    full = true
    petsc_options = '-ksp_diagonal_scale -ksp_diagonal_scale_fix'
    petsc_options_iname = '-pc_type -sub_pc_type -sub_pc_factor_shift_type -pc_asm_overlap'
    petsc_options_value = ' asm      lu           NONZERO                   2'
  []
  [preferred_but_might_not_be_installed]
    type = SMP
    full = true
    petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
    petsc_options_value = ' lu       mumps'
  []
[]

[Executioner]
  #type = Transient
  #type = Steady
  #solve_type = NEWTON
  #automatic_scaling = true
 #end_time = 9467280000 # 300y
 #end_time = 31536000000 # 1000y
 #end_time = 94608000000 # 3000y
 #end_time = 157680000000 # 5000y
 #end_time = 315360000000 # 10000y
 #end_time = 473040000000 #15000
 #end_time = 630720000000 #20000
  nl_max_its = 250# max Non linear iterations before cutback is applied
 # l_max_its = 1000
 #dtmax = 473364000 # 15y
  #dtmax = 630720000 # 20y
  #dtmin = 1750.0
   #dtmin = 86400 
  #nl_abs_tol = 1e-6
  #num_steps = 10
  #steady_state_detection = true
  #steady_state_tolerance = 1e-30
  #[TimeStepper]
  #  type = IterationAdaptiveDT
  #  dt = 31557600 # 1y
  #  growth_factor = 2 # if iterations is less than nl max --> if iteration runs smoothly
  #  cutback_factor = 0.5 # if iteration exceeds nl max --> runs poorly
  #[]
#[]
  type = Steady
  solve_type = NEWTON
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  petsc_options_iname = '-ksp_type -pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'preonly lu       superlu_dist'
[]
[Outputs]
  [./my_checkpoint]
    type = Checkpoint
    wall_time_interval = 360000 # interval length in seconds
  [../]
  exodus = true
  [csv]
    type = CSV
  []
[]
