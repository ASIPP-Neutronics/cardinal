[Mesh]
  [tube]
    type = FileMeshGenerator
    file = tube_in.e
  []
  [to_quad8]
    type = NekMeshGenerator
    input = tube
    boundary = 'rmin rmax'
    radius = '0.05 0.2'
  []

  parallel_type = replicated
[]
