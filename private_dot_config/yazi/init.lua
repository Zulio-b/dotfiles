-- require("starship"):setup()

-- local old_build = Tab.build
-- Tab.build = function(self, ...)
-- 	local c = self._chunks
-- 	-- ui.Pad(top, right, bottom, left)
-- 	self._chunks = {
-- 		c[1]:pad(ui.Pad(1, 0, 0, 0)),
-- 		c[2]:pad(ui.Pad(1, 0, 0, 0)),
-- 		c[3]:pad(ui.Pad(1, 0, 0, 0)),
-- 	}
-- 	old_build(self, ...)
-- end

-- require("full-border"):setup {
-- 	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
-- 	type = ui.Border.PLAIN,
-- }


require("git"):setup {
	-- Order of status signs showing in the linemode
	order = 1500,
}
require("glyphmark"):setup()
require("sduf"):setup()


