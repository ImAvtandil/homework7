{application, 'homework7', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['cache_server','homework7_app','homework7_sup','routes','time_helper','toppage_h']},
	{registered, [homework7_sup]},
	{applications, [kernel,stdlib,cowboy,jsone,homework6]},
	{optional_applications, []},
	{mod, {homework7_app, []}},
	{env, []}
]}.