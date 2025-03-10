[Mesh]
  [sphere]
    type = FileMeshGenerator
    file = ../../neutronics/meshes/sphere.e
  []
  [solid]
    type = CombinerGenerator
    inputs = sphere
    positions = '0 0 0
                 0 0 4
                 0 0 8'
  []
[]

[Problem]
  type = OpenMCCellAverageProblem
  power = 100.0
  temperature_blocks = '1'
  tally_blocks = '1'
  cell_level = 0
  tally_type = cell
  initial_properties = xml

  k_trigger = std_dev
  k_trigger_threshold = 1e-4
  max_batches = 100
  source_strength = 1e6
[]

[Executioner]
  type = Transient
  num_steps = 1
[]

[Outputs]
  exodus = true
[]
