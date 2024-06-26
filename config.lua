HS = {}

-- Paste your WebHook to server/sv_webhook
HS.discordLogs = false -- false/true

-- Update-Check:
HS.Updates = true -- false/true

-- Reward amounts:
HS.reward = { 
    min = 300,  -- Minimum reward from a delivery
    max = 600   -- Maximum reward from a delivery
}

-- The location to start the job
HS.locations = {
    startPos = vector3(95.0420, -1810.1549, 27.0822),       -- NPC location and ox_target
    vehicleSpawn = {
        spawnPos = vector3(106.0365, -1814.0081, 26.3405),  -- Vehicle spawn location
        heading = 140.5                                     -- Spawned vehicle heading
    }
}

-- All blip settings:
HS.Blips = {
    -- Job start blip:
    jobStart = {
        text = "Delivery Job", -- Blip label
        blipSprite = 525,
        blipScale = 1.0,
        blipColour = 56
    },
    -- Delivery destination blip:
    destination = {
        text = "Delivery Destination", -- Blip label
        blipSprite = 478,
        blipScale = 1.15,
        blipColour = 56
    },
    -- Return van blip:
    returnVeh = {
        text = "Return Your Van", -- Blip label
        blipSprite = 525,
        blipScale = 1.15,
        blipColour = 56
    }
}

-- Vehicle to spawn for worker:
HS.jobvehicle = 'burrito3'

-- Job startting point NPC:
HS.npc = {
    model = 'a_m_y_business_02',
    heading = 231.3836,
    range = 25.0,
    animation = 'amb@code_human_cross_road@male@base',
    anim_dir = 'base'
}

-- All the locations where you can deliver:
HS.Coords = {
        vector4(1124.0480, -344.9734, 67.1329, 197.8524), -- x, y, z, h
        vector4(1247.2285, -350.1461, 69.2098, 350.2386),
        vector4(1070.7242, -780.4130, 58.3525, 62.1381),
        vector4(1379.7180, -772.7025, 67.3174, 16.7935),
        vector4(-1054.2860, -248.2039, 37.8622, 201.9521),
        vector4(-1178.1066, -891.4964, 13.7629, 293.7206),
        vector4(-1221.9998, -1096.0985, 8.1224, 104.8023),
        vector4(-1038.1787, -1396.8811, 5.5532, 81.2536),
        vector4(-642.8484, -1227.9310, 11.5476, 326.5365),
        vector4(-601.6919, -1129.7461, 22.3242, 264.5038),
        vector4(-1327.3658, -401.2958, 36.5998, 34.8150),
        vector4(-27.0494, -1673.0443, 29.4917, 153.7410),
        vector4(868.4524, -1640.0925, 30.3374, 86.0588),
        vector4(-822.8423, -1099.0448, 11.1544, 307.1489),
        vector4(-840.2119, -800.8962, 19.1629, 94.5074),
        vector4(-1348.7122, -636.3391, 27.6235, 301.4200),
        vector4(-1548.5983, -436.0727, 35.8867, 242.3553),
        vector4(-803.3989, -224.0666, 37.2253, 123.7988),
        vector4(895.5984, -179.1331, 74.7002, 334.4260),
        vector4(922.4135, 44.4113, 81.1063, 46.0205),
        vector4(1234.0159, -354.4503, 69.0821, 86.2427),
        vector4(1153.6527, -777.0151, 57.5987, 351.3918),
        vector4(495.8371, -638.0825, 25.0071, 268.0489),
        vector4(490.1256, -801.0988, 24.8867, 280.1663),
        vector4(482.9123, -1304.7682, 29.2411, 219.1928),
        vector4(747.0247, -1400.2815, 26.5568, 197.9921),
        vector4(977.3196, -1488.1321, 31.4379, 86.3230),
        vector4(1151.0658, -1529.5626, 35.3699, 336.0793),
        vector4(1143.1812, -986.7097, 45.9017, 272.9602),
        vector4(914.3254, -2153.8147, 30.4947, 268.9780),
        vector4(473.6251, -1951.8716, 24.6027, 118.7424),
        vector4(-528.5302, -1784.3002, 21.5717, 339.4389),
        vector4(-828.4149, -1260.1095, 5.0004, 188.4112),
        vector4(-741.3727, -1127.5054, 10.5979, 120.0631),
        vector4(-1470.0979, -331.1387, 44.8143, 304.1255),
        vector4(-102.5466, -80.6750, 57.2823, 140.9197),
        vector4(192.4507, -1298.4409, 29.3266, 251.4986),
        vector4(-295.6412, -1295.7332, 31.2595, 280.4726),
        vector4(-116.1236, -609.4360, 36.2807, 248.4441),
        vector4(65.5402, -138.7314, 55.0338, 195.7148),
        vector4(537.1359, 101.2853, 96.5331, 139.7076),
        vector4(750.1085, 223.1192, 87.4229, 128.2799),
        vector4(-874.8371, -308.8702, 39.5327, 347.3552),
        vector4(-1464.0391, -704.7132, 26.7773, 147.1042),
        vector4(-1390.1890, -745.7177, 24.6254, 128.4867),
        vector4(-989.4794, -1576.0149, 5.1711, 126.7331),
        vector4(-1109.8677, -1454.3369, 5.0675, 246.5120),
        vector4(-886.1542, -1232.3721, 5.6559, 359.7247),
        vector4(-737.3716, -1118.3368, 10.8720, 21.5929),
        vector4(-599.4247, -930.7106, 23.8634, 166.8997),
        vector4(4.1299, -706.7904, 45.9730, 202.9194),
        vector4(6.0305, -933.7689, 29.9050, 109.8928),
        vector4(73.5884, -1027.3420, 29.4759, 260.9707),
        vector4(326.9611, -72.8116, 70.9262, 173.6589),
        vector4(-576.2967, 275.7155, 82.7586, 183.7111),
        vector4(-1680.2363, -292.6286, 51.8834, 216.0331),
        vector4(-2066.5608, -312.5499, 13.2722, 353.2217),
        vector4(435.9941, 215.7058, 103.1654, 331.1734),
        vector4(-599.6205, -251.2529, 36.2854, 296.3437),
        vector4(-527.1480, -679.1134, 33.6711, 55.8755)
}

-- Ped models for waiting npcs:
HS.DeliveryNPC = {
    "a_m_y_soucent_01",
    "a_m_y_vinewood_0",
    "a_m_m_eastsa_01",
    "a_f_m_eastsa_01",
    "a_f_m_eastsa_02"
}

-- Waiting npc animation:
HS.DeliveryNPCAnim = {
    anim = 'amb@world_human_hang_out_street@Female_arm_side@idle_a',
    dict = 'idle_a'
}