-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
	{
		description = "TypeScript compiler configuration file",
		fileMatch = { "tsconfig.json", "tsconfig.*.json" },
		url = "https://json.schemastore.org/tsconfig.json",
	},
	{
		description = "Lerna config",
		fileMatch = { "lerna.json" },
		url = "https://json.schemastore.org/lerna.json",
	},
	{
		description = "Babel configuration",
		fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
		url = "https://json.schemastore.org/babelrc.json",
	},
	{
		description = "ESLint config",
		fileMatch = { ".eslintrc.json", ".eslintrc" },
		url = "https://json.schemastore.org/eslintrc.json",
	},
	{
		description = "Bucklescript config",
		fileMatch = { "bsconfig.json" },
		url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
	},
	{
		description = "Prettier config",
		fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
		url = "https://json.schemastore.org/prettierrc",
	},
	{
		description = "Vercel Now config",
		fileMatch = { "now.json" },
		url = "https://json.schemastore.org/now",
	},
	{
		description = "Stylelint config",
		fileMatch = {
			".stylelintrc",
			".stylelintrc.json",
			"stylelint.config.json",
		},
		url = "https://json.schemastore.org/stylelintrc",
	},
	{
		description = "A JSON schema for the ASP.NET LaunchSettings.json files",
		fileMatch = { "launchsettings.json" },
		url = "https://json.schemastore.org/launchsettings.json",
	},
	{
		description = "Schema for CMake Presets",
		fileMatch = { "CMakePresets.json", "CMakeUserPresets.json" },
		url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
	},
	{
		description = "Configuration file as an alternative for configuring your repository in the settings page.",
		fileMatch = { ".codeclimate.json" },
		url = "https://json.schemastore.org/codeclimate.json",
	},
	{
		description = "LLVM compilation database",
		fileMatch = { "compile_commands.json" },
		url = "https://json.schemastore.org/compile-commands.json",
	},
	{
		description = "Config file for Command Task Runner",
		fileMatch = { "commands.json" },
		url = "https://json.schemastore.org/commands.json",
	},
	{
		description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
		fileMatch = { "*.cf.json", "cloudformation.json" },
		url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
	},
	{
		description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
		fileMatch = { "serverless.template", "*.sam.json", "sam.json" },
		url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
	},
	{
		description = "Json schema for properties json file for a GitHub Workflow template",
		fileMatch = { ".github/workflow-templates/**.properties.json" },
		url = "https://json.schemastore.org/github-workflow-template-properties.json",
	},
	{
		description = "golangci-lint configuration file",
		fileMatch = { ".golangci.toml", ".golangci.json" },
		url = "https://json.schemastore.org/golangci-lint.json",
	},
	{
		description = "JSON schema for the JSON Feed format",
		fileMatch = { "feed.json" },
		url = "https://json.schemastore.org/feed.json",
		versions = {
			["1"] = "https://json.schemastore.org/feed-1.json",
			["1.1"] = "https://json.schemastore.org/feed.json",
		},
	},
	{
		description = "Packer template JSON configuration",
		fileMatch = { "packer.json" },
		url = "https://json.schemastore.org/packer.json",
	},
	{
		description = "NPM configuration file",
		fileMatch = { "package.json" },
		url = "https://json.schemastore.org/package.json",
	},
	{
		description = "JSON schema for Visual Studio component configuration files",
		fileMatch = { "*.vsconfig" },
		url = "https://json.schemastore.org/vsconfig.json",
	},
	{
		description = "Resume json",
		fileMatch = { "resume.json" },
		url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
	},
}

local SETTINGS = {
	settings = { json = { schemas = schemas } },
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return SETTINGS

-- local present, schemastore = pcall(require, "schemastore")
-- local json_schemas = {}

-- if present then
--   json_schemas = schemastore.json.schemas({
--     select = { ".eslintrc", "package.json" }
--   })
-- end

-- local schema = {
--   settings = {
--     json = {
--       schemas = vim.list_extend(
--         {
--           {
--             description = "json-ls configuration file",
--             fileMatch = { ".jsonls.json", "jsonls.json" },
--             url = "https://gist.githubusercontent.com/tamago324/d09875f231ee4f149ed63766af3cc0ca/raw/ee598f1e8348b94bb5d7a12ef111775679242f21/schema-jsonls.json",
--           },
--           {
--             description = "TypeScript compiler configuration file",
--             fileMatch = { "tsconfig.json", "tsconfig.*.json" },
--             url = "http://json.schemastore.org/tsconfig",
--           },
--           {
--             description = "Lerna config",
--             fileMatch = { "lerna.json" },
--             url = "http://json.schemastore.org/lerna",
--           },
--           {
--             description = "Babel configuration",
--             fileMatch = {
--               ".babelrc.json",
--               ".babelrc",
--               "babel.config.json",
--             },
--             url = "http://json.schemastore.org/lerna",
--           },
--           {
--             description = "ESLint config",
--             fileMatch = { ".eslintrc.json", ".eslintrc" },
--             url = "http://json.schemastore.org/eslintrc",
--           },
--           {
--             description = "Bucklescript config",
--             fileMatch = { "bsconfig.json" },
--             url = "https://bucklescript.github.io/bucklescript/docson/build-schema.json",
--           },
--           {
--             description = "Prettier config",
--             fileMatch = {
--               ".prettierrc",
--               ".prettierrc.json",
--               "prettier.config.json",
--             },
--             url = "http://json.schemastore.org/prettierrc",
--           },
--           {
--             description = "Vercel Now config",
--             fileMatch = { "now.json" },
--             url = "http://json.schemastore.org/now",
--           },
--           {
--             description = "Stylelint config",
--             fileMatch = {
--               ".stylelintrc",
--               ".stylelintrc.json",
--               "stylelint.config.json",
--             },
--             url = "http://json.schemastore.org/stylelintrc",
--           },
--           {
--             description = "SumnekoLua config",
--             fileMatch = {
--               ".sumnekorc.json",
--               "sumnekorc.json",
--               "sumnekorc",
--               ".sumnekorc",
--               ".sumnekorc.lua",
--               "sumnekorc.lua",
--               "sumneko_lua.lua",
--               ".luarc.json",
--               "luarc.json",
--             },
--             url = "https://raw.githubusercontent.com/sumneko/vscode-lua/master/setting/schema.json",
--           },
--         },
--         json_schemas
--       ),
--     },
--   },
-- }

-- return schema
