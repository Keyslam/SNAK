return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 10,
  height = 10,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      filename = "tilesets/tiles.tsx",
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "../image/SNAK-Tileset.png",
      imagewidth = 640,
      imageheight = 192,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 64,
        height = 64
      },
      properties = {},
      terrains = {},
      tilecount = 30,
      tiles = {
        {
          id = 0,
          type = "wall",
          properties = {
            ["color"] = 1
          }
        },
        {
          id = 1,
          type = "wall",
          properties = {
            ["color"] = 2
          }
        },
        {
          id = 2,
          type = "wall",
          properties = {
            ["color"] = 3
          }
        },
        {
          id = 3,
          type = "wall"
        },
        {
          id = 5,
          type = "wall"
        },
        {
          id = 6,
          type = "wall"
        },
        {
          id = 7,
          type = "wall"
        },
        {
          id = 8,
          type = "wall"
        },
        {
          id = 9,
          type = "wall"
        },
        {
          id = 10,
          type = "wall",
          properties = {
            ["color"] = 1
          }
        },
        {
          id = 11,
          type = "wall",
          properties = {
            ["color"] = 2
          }
        },
        {
          id = 12,
          type = "wall",
          properties = {
            ["color"] = 3
          }
        },
        {
          id = 13,
          type = "wall"
        },
        {
          id = 14,
          type = "snake"
        },
        {
          id = 15,
          type = "wall"
        },
        {
          id = 16,
          type = "wall"
        },
        {
          id = 17,
          type = "wall"
        },
        {
          id = 18,
          type = "wall"
        },
        {
          id = 19,
          type = "wall"
        },
        {
          id = 20,
          type = "pellet",
          properties = {
            ["color"] = 1
          }
        },
        {
          id = 21,
          type = "pellet",
          properties = {
            ["color"] = 2
          }
        },
        {
          id = 22,
          type = "pellet",
          properties = {
            ["color"] = 3
          }
        },
        {
          id = 23,
          type = "pellet"
        },
        {
          id = 25,
          type = "wall"
        },
        {
          id = 26,
          type = "wall"
        },
        {
          id = 27,
          type = "wall"
        },
        {
          id = 28,
          type = "wall"
        },
        {
          id = 29,
          type = "wall"
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "entities",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25,
        25, 15, 21, 12, 23, 13, 0, 0, 0, 25,
        25, 25, 22, 12, 21, 13, 0, 25, 0, 25,
        25, 25, 23, 12, 22, 13, 0, 0, 0, 25,
        25, 25, 25, 25, 25, 25, 23, 22, 21, 25,
        25, 25, 0, 13, 24, 11, 0, 0, 0, 25,
        25, 24, 0, 13, 23, 11, 0, 0, 0, 25,
        25, 24, 0, 13, 22, 11, 0, 0, 0, 25,
        25, 0, 0, 13, 21, 11, 0, 0, 0, 25,
        25, 25, 25, 25, 25, 25, 25, 25, 25, 25
      }
    },
    {
      type = "tilelayer",
      id = 2,
      name = "tiles",
      x = 0,
      y = 0,
      width = 10,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        6, 7, 7, 7, 7, 7, 7, 7, 7, 8,
        16, 0, 0, 12, 0, 13, 0, 0, 0, 18,
        16, 0, 0, 12, 0, 13, 0, 0, 0, 18,
        16, 0, 0, 12, 0, 13, 0, 0, 0, 18,
        16, 17, 17, 17, 17, 17, 0, 0, 0, 18,
        16, 0, 0, 13, 0, 11, 0, 0, 0, 18,
        16, 0, 0, 13, 0, 11, 0, 0, 0, 18,
        16, 0, 0, 13, 0, 11, 0, 0, 0, 18,
        16, 0, 0, 13, 0, 11, 0, 0, 0, 18,
        26, 27, 27, 27, 27, 27, 27, 27, 27, 28
      }
    }
  }
}
