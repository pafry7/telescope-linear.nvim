return require("telescope").register_extension {
  setup = function(config)
    require("linear").setup(config)
  end,
  exports = {
    run = require("linear").run,
  }
}
