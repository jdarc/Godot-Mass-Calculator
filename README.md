# Mass Calculator for Godot 4

Blender-inspired mass calculator plugin for Godot's RigidBody3D nodes.
Seamlessly computes the mass of a selected RigidBody3D node based on its collision shapes.
If the selected node is not a RigidBody3D, the plugin recursively searches the scene to identify and calculate the mass for all RigidBody3D nodes, using their associated collision shapes.

## Features

- Provides a comprehensive set of RigidBody materials inspired by Blender 4.5 for realistic physics simulations.
- Intuitive scene tree context menu for quick and efficient material selection.
- Automatically calculates the mass of selected RigidBody3D nodes or recursively searches the scene for RigidBody3D nodes.
- Mass calculations are derived from the collision shapes of RigidBody3D nodes for accurate results.

## Installation

1. Download or clone this repository to your local machine.
2. Copy the `massimo` folder into the `addons` directory of your Godot project.
3. In the Godot editor, navigate to `Project → Project Settings → Plugins` and enable the `Mass Calculator` plugin.

## Usage

1. Select a `RigidBody3D` or any `Node3D`-derived node in the scene tree.
2. Right-click the selected node to open its context menu.
3. Hover over the `Mass Calculator` option to view available material presets.
4. Select a material to calculate the mass of the chosen `RigidBody3D` nodes or any `RigidBody3D` nodes among its children.

## License

This project is licensed under the MIT License - see the [LICENSE](addons/massimo/LICENSE.txt) file for details.

## Support

If you encounter any issues or have suggestions, please [open an issue](https://github.com/jdarc/Godot-Mass-Calculator/issues) or submit a pull request.

## Credit

Thanks go to [nenovmy](https://github.com/nenovmy/Godot_Mass_Calc) for his mass calculator implementation.