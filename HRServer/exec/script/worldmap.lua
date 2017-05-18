-- �����ͼ
local TMX_WIDTH 			= 96;  	-- һ��tmx��ͼ��С
local TMX_HEIGHT 			= 96;  	-- һ��tmx��ͼ��С

MAPUNIT_TYPE_CITY			=	1	-- �ǳ�
MAPUNIT_TYPE_ARMY			=	2	-- ����


-- �����ͼ��ʼ��
function IN_OnWorldMapInit( nMaxWidth, nMaxHeight )
	-- Ԥ�Ƚ�������Ϣ��ֵ��g_map.m_aTileData
	for posx = 0, nMaxWidth-1, 1 do
		for posy = 0, nMaxHeight-1, 1 do
			if IN_OnWorldMapBlock( posx, posy ) < 0 then
				c_map_addobject( 0, posx, posy, 100 );
			end
		end
	end
	
end

-- ��ͼ�赲
function IN_OnWorldMapBlock( posx, posy )
	-- ��ת����һС���ͼ�����꣬��Ϊ��ͼ��N*N��ƴ������
	local localposx = math.floor( posx % TMX_WIDTH );
	local localposy = math.floor( posy % TMX_HEIGHT );
	local index = localposx + localposy*TMX_HEIGHT + 1;

	-- ��������
	--if posx >= 477 and posx <= 483 and posy >= 477 and posy <= 483 then
		--return -1;
	--end
	
	-- ����������Ĭ��û���赲����
	--if posx >= 455 and posx <= 505 and posy >= 455 and posy <= 505 then
		--return 0;
	--end
	
	-- �ر������
	local groundData = tiledMap.layers[1].data[index];
	if groundData >= 17 and groundData <= 46 or 
	   groundData >= 65 and groundData <= 77 or 
	   groundData >= 79 and groundData <= 84 or 
	   groundData >= 86 and groundData <= 105 or 
	   groundData == 109 or 
	   groundData == 110 then
		return -1;
	end
	
	-- װ�β�����
	local decorateData1 = tiledMap.layers[2].data[index];
	if decorateData1 >= 17 and decorateData1 <= 46 or 
	   decorateData1 >= 65 and decorateData1 <= 77 or 
	   decorateData1 >= 79 and decorateData1 <= 84 or 
	   decorateData1 >= 86 and decorateData1 <= 104 or 
	   decorateData1 == 109 or 
	   decorateData1 == 110 then
		return -1;
	end
	
	local decorateData2 = tiledMap.layers[3].data[index];
	if decorateData2 >= 17 and decorateData2 <= 46 or 
	   decorateData2 >= 65 and decorateData2 <= 77 or 
	   decorateData2 >= 79 and decorateData2 <= 84 or 
	   decorateData2 >= 86 and decorateData2 <= 104 or 
	   decorateData2 == 109 or 
	   decorateData2 == 110 then
		return -1;
	end
	
	return 0;
end

-- ˢ��ͼ
function IN_OnWorldMapBrush()
	-- ˢ������
	RobotCreate();
end

-- ��ȡ�ڼ�Ȧ
function getCircleID( posx, posy )
	local a = math.floor(posx/65) + 1;
	local b = math.floor(posy/65) + 1;
	local circleid = math.min( math.min(16-a,a), math.min(16-b,b) );
	return circleid
end

