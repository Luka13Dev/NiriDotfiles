local function source_matugen()
	local matugen_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"
	local file, err = io.open(matugen_path, "r")
	if err ~= nil then
		vim.cmd("colorscheme default")
		vim.notify("Matugen: tema ainda não gerado. Rode: matugen image <wallpaper>", vim.log.levels.INFO)
	else
		io.close(file)
		dofile(matugen_path)
	end
end

source_matugen()

vim.api.nvim_create_autocmd("Signal", {
	pattern = "SIGUSR1",
	callback = source_matugen,
})
