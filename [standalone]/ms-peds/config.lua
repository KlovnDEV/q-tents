Config = {}

Config.Invincible = true -- Is the ped going to be invincible?
Config.Frozen = true -- Is the ped frozen in place?
Config.Stoic = true -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}

Config.PedList = {
	
	-- Barber Shops
	{
		model = `s_f_m_fembarber`, -- Model name as a hash.
		coords = vector4(-34.42, -151.15, 57.09, 180.0), -- Hawick Ave (X, Y, Z, Heading)
		gender = 'female' -- The gender of the ped, used for the CreatePed native.
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-279.89, 6227.61, 31.71, 50.0), -- Paleto Bay
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-817.19, -183.30, 37.57, 130.0), -- Mad Wayne Thunder Drive
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(-1283.62, -1119.24, 7.00, 110.0), -- Magellan Ave
		gender = 'female'
	},

	{
		model = `s_f_m_fembarber`,
		coords = vector4(137.61, -1709.78, 29.30, 320.0), -- Carson Ave
		gender = 'female'
	},

	-- BANK PED'S
    -- {
    --     model = `ig_bankman`,
    --     coords = vector4(241.44, 227.19, 106.29, 170.43),
    --     gender = 'male'
    -- },
    -- {
    --     model = `ig_bankman`,
    --     coords = vector4(313.84, -280.58, 54.16, 338.31), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(149.46, -1042.09, 29.37, 335.43), 
    --     gender = 'male'
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-351.23, -51.28, 49.04, 341.73), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-1211.9, -331.9, 37.78, 20.07), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-2961.14, 483.09, 15.7, 83.84), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(1174.8, 2708.2, 38.09, 178.52), 
    --     gender = 'male' 
    -- },
    -- {
    --     model = `ig_bankman`, 
    --     coords = vector4(-112.22, 6471.01, 31.63, 134.18), 
    --     gender = 'male' 
    -- },
	--------- Dress Shop -----------
	{
		model = `s_f_y_shop_low`,
		coords = vector4(73.98, -1393.04, 29.38, 267.54),
		gender = 'female'
	},
	{
		model = `s_f_y_shop_low`,
		coords = vector4(-1102.1, 2711.85, 19.11, 220.36),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(126.95, -224.23, 54.56, 62.39),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-164.44, -301.42, 39.73, 249.63),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(427.0, -806.46, 29.49, 95.77),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-708.25, -153.04, 37.42, 116.82),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-823.07, -1072.28, 11.33, 207.75),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-1193.92, -766.98, 17.32, 215.65),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-1449.98, -239.17, 49.81, 49.23),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-708.24, -153.02, 37.42, 117.62),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(-3169.8, 1042.39, 20.86, 65.91),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(612.91, 2763.61, 42.09, 273.0),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(1197.29, 2711.67, 38.22, 172.62),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(1695.37, 4822.39, 42.06, 98.86),
		gender = 'female'
	},
    {
		model = `s_f_y_shop_low`,
		coords = vector4(5.33, 6510.97, 31.88, 43.36),
		gender = 'female'
	},
	
    --------- Shops -----------
    -- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(24.24, -1347.33, 29.5, 276.86),
	-- 	gender = 'male'
	-- },

	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-2592.77, 1878.57, 175.56, 221.29),
	-- 	gender = 'male'
	-- },
	
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(225.65, -909.83, 30.73, 351.32),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-47.4, -1758.65, 29.42, 47.22),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-706.16, -914.51, 19.22, 96.95),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-1221.97, -908.32, 12.33, 32.06),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(1134.21, -982.49, 46.42, 277.1),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(1164.81, -323.63, 69.21, 97.58),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `a_m_y_hippy_01`,
	-- 	coords = vector4(-1486.19, -377.99, 40.16, 128.18),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(372.56, 326.44, 103.57, 257.55),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-3242.25, 1000.01, 12.83, 354.51),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(2557.21, 380.81, 108.62, 359.23),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(549.11, 2671.34, 42.16, 100.41),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `a_m_y_hippy_01`,
	-- 	coords = vector4(1165.92, 2710.77, 38.16, 175.89),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(1960.1, 3740.03, 32.34, 300.65),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(1697.41, 4923.4, 42.06, 325.06),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(1727.83, 6415.29, 35.04, 243.91),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(-156.21, 6327.13, 31.58, 317.09),
	-- 	gender = 'male'
	-- },
	-- {
	-- 	model = `mp_m_shopkeep_01`,
	-- 	coords = vector4(161.96, 6636.4, 31.56, 136.16),
	-- 	gender = 'male'
	-- },
	----------- Smoke on the water --------
	{
		model = `a_f_m_business_02`,
		coords = vector4(-1171.29, -1571.1, 4.66, 124.95),
		gender = 'female'
	},
	----------- Sea World --------
	{
		model = `a_m_y_epsilon_01`,
		coords = vector4(-1686.34, -1072.61, 13.15, 50.74),
		gender = 'male'
	},

	---house
	{
		model = `a_m_y_business_03`,
		coords = vector4(-617.25, -1622.73, 33.01, 353.86),
		gender = 'male'
	},
	
    ---------- Garages ----------
	----Jonogon Garages
	{
		model = `a_m_o_soucent_03`,
		coords = vector4(247.99, -791.58, 30.43, 76.46),
		gender = 'male'
	},
	------Casino Garages
	{
		model = `a_m_o_soucent_03`,
		coords = vector4(886.76, 0.22, 78.77, 146.4),
		gender = 'male'
	},
	-----Airport Garage
	{
		model = `a_m_o_soucent_03`,
		coords = vector4(-938.62, -2076.71, 9.3, 136.13),
		gender = 'male'
	},
	-----Narayonganj Garage
	{
		model = `a_m_o_soucent_03`,
		coords = vector4(1729.25, 3706.88, 34.13, 19.52),
		gender = 'male'
	},
	-----Savar Garage
	{
		model = `a_m_o_soucent_03`,
		coords = vector4(84.42, 6421.25, 31.58, 322.2),
		gender = 'male'
	},
	-----------------/ sandysheriff

	{
		model = `a_m_o_soucent_03`,
		coords = vector4(-85.24, 838.23, 235.72, 10.56),
		gender = 'female'
	},
	------------------- JJJ GARAGE
	{
		model = `s_m_y_sheriff_01`, 
		coords = vector4(1876.83, 3691.28, 33.54, 303.21),
		gender = 'male', 
		animDict = 'abigail_mcs_1_concat-0', 
		anim = 'csb_abigail_dual-0', 
		flag = 1, 
		scenario = 'WORLD_HUMAN_AA_COFFEE', 
		minusOne = true,
		freeze = true,
		invincible = true,
	},
	 ---------- Depot ----------
	{
		model = `ig_sacha`,
		coords = vector4(407.63, -1624.77, 29.29, 227.33),
		gender = 'male'
	},

	{
		model = `ig_sacha`,
		coords = vector4(1894.45, 3715.1, 32.76, 123.05),
		gender = 'male'
	},
	{
		model = `ig_sacha`,
		coords = vector4(-220.23, 6197.9, 31.49, 312.97),
		gender = 'male'
	},
	 ---------- Hospital ----------
	{
		model = `mp_f_meth_01`,
		coords = vector4(311.63, -594.13, 43.28, 344.49),
		gender = 'female'
	},
	---------- car wash ----------
	{
		model = `cs_old_man2`,
		coords = vector4(25.24, -1389.36, 29.36, 188.12),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(174.76, -1739.65, 29.29, 10.6),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(-702.39, -933.13, 19.01, 271.23),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(1361.23, 3595.51, 34.91, 203.78),
		gender = 'male'
	},
	{
		model = `cs_old_man2`,
		coords = vector4(-94.67, 6398.68, 31.49, 137.75),
		gender = 'male'
	},

	---------- Gun Shop ---------
	{
			model = `s_m_y_ammucity_01`, 
			coords = vector4(22.57, -1105.44, 29.8, 164.13),
			gender = 'male', 
	},
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(253.76, -50.65, 69.94, 69.41),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(842.26, -1035.25, 28.19, 2.3),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-662.56, -933.57, 21.83, 182.83),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-662.56, -933.57, 21.83, 182.83),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(2567.92, 292.59, 108.73, 359.17),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(1692.14, 3760.77, 34.71, 223.38),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(-331.58, 6085.02, 31.45, 224.08),
		gender = 'male', 
    },
	{
		model = `s_m_y_ammucity_01`, 
		coords = vector4(810.39, -2159.03, 29.62, 0.18),
		gender = 'male', 
    },

	---------- City Hall ---------
		{
			model = `csb_tomcasino`, 
			coords = vector4(-269.05, -955.92, 31.22, 205.86),
			gender = 'male', 
	},
 	---------- Casino shop ---------
		{
			model = `u_f_m_casinoshop_01`, 
			coords = vector4(937.45, 27.37, 71.83, 43.34),
			gender = 'female', 
	},
	------------- hardwere store ---------
	{
		model = `csb_money`, 
		coords = vector4(46.73, -1749.73, 29.63, 52.27),
		gender = 'male', 
    },
	{
		model = `csb_money`, 
		coords = vector4(2747.29, 3473.07, 55.67, 250.46),
		gender = 'male', 
    },
	{
		model = `csb_money`, 
		coords = vector4(-421.94, 6136.67, 31.88, 176.82),
		gender = 'male', 
    },
	---------------DigitalDel
	{
        model = `ig_lifeinvad_01`,
        coords = vector4(149.08, -234.68, 54.42, 337.93),
        gender = 'male', 
    },
	-------------Repair
	{
        model = `a_m_m_hillbilly_01`,
        coords = vector4(-180.71, -1282.51, 31.29, 94.5),
        gender = 'male', 
    },
	------------Emnei
	{
        model = `a_c_chimp`,
        coords = vector4(1088.97, -2003.65, 31.14, 326.61),
        gender = 'male', 
    },
}