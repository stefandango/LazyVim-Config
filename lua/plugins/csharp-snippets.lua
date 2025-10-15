return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { 
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      
      -- Add C# specific snippets
      ls.add_snippets("cs", {
        s("class", {
          t("public class "), i(1, "ClassName"), t({
            "",
            "{",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
        
        s("interface", {
          t("public interface I"), i(1, "InterfaceName"), t({
            "",
            "{",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
        
        s("method", {
          t("public "), i(1, "void"), t(" "), i(2, "MethodName"), t("("), i(3), t({
            ")",
            "{",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
        
        s("prop", {
          t("public "), i(1, "string"), t(" "), i(2, "PropertyName"), t(" { get; set; }")
        }),
        
        s("ctor", {
          t("public "), i(1, "ClassName"), t("("), i(2), t({
            ")",
            "{",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
        
        s("test", {
          t("[Test]"), t({
            "",
            "public void "
          }), i(1, "TestMethodName"), t("()"), t({
            "",
            "{",
            "    // Arrange",
            "    "
          }), i(2), t({
            "",
            "",
            "    // Act",
            "    "
          }), i(3), t({
            "",
            "",
            "    // Assert",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
        
        s("controller", {
          t("[ApiController]"), t({
            "",
            "[Route(\"api/[controller]\")]",
            "public class "
          }), i(1, "ControllerName"), t("Controller : ControllerBase"), t({
            "",
            "{",
            "    "
          }), i(0), t({
            "",
            "}"
          })
        }),
      })
      
      -- Load friendly snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}