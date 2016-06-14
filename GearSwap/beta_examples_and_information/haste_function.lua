---Includes choices for each increment of +1 song for marches
haste_array = {
	['March']={ --Permutations for buffactive['March']
		[1]={64,80,96,112,128,144,
			96,112,128,144,160,176,
			102,154},
		[2]=
	}
}
---Simplified to only trust marches and max ones. 
--Neither this nor above iteration attempts to account for SV or marcato

haste_array = {
	['March']={ --Permutations for buffactive['March']
		[1]={64,144, --Trust, Real Bard
			96,176,
			102,154},
		[2]={160,166,198,
			320,298,330},
		[3]={262,474}
		},
	['Haste']={
		[1]={153,307, --Haste 1 and 2
			307,362,448}, --Indi and Geo-Haste bubbles with at least Dunna (first val is entrust)
		[2]={448}
		},
	['Embrava']={
		[1]={256}
		}

}

--Non-trust considerate version
haste_array = {
	['March']={ --Permutations for buffactive['March']
		[1]={144, 176, 154}, --Advancing, Victory, Honor
		[2]={298, 320, 330},
		[3]={474}
		},
	['Haste']={
		[1]={153,307,307,362,448}, --Hahste 1 & 2, then Indi and Geo-Haste bubbles with at least Dunna (first val is entrust)
		[2]={448}
		},
	['Embrava']={
		[1]={256}
		}

}
haste_permutations = {}
function haste_permutations()
	for i=1,#haste_array do 
		--variable returning #s of active buff from array to determine permutations
		local haste_buff = buffactive[haste_array[i]] 
		if haste_buff then	
			for haste_buff,potency in pairs(haste_array[i]) do
				
			end
		end
	end
end




