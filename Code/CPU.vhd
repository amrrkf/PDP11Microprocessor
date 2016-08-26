Library ieee;
use ieee.std_logic_1164.all;

Entity CPU is
port(CLK,RST: in std_logic);   
end CPU;

Architecture arch of CPU is

	Component CU is
	port(CLK,RST: in std_logic;
		IR : in std_logic_vector(15 downto 0);
		Z_flag : in std_logic;
		-- F1 signals --
		PCout,MDRout,Zout,SPout,SRCout,DSTout,TMPout,Addressout :out std_logic;
		-- F2 signals --
		PCin,IRin,Zin,SPin : out std_logic;
		-- F3 signals --
		MARin,MDRin,TMPin : out std_logic;
		-- F4 signals --
		Yin,SRCin,DSTin : out std_logic;
		-- F5 signals --
		ALSUin :out  std_logic_vector(3 downto 0);
		-- F6 signals --
		R,W,HLT : out std_logic;
		-- F7 signal --
		ClearY : out std_logic;
		-- F8 signal --
		Carryin : out std_logic;
		-- F9 signal --
		FLAGS_E : out std_logic;
		R0in,R0out,R1in,R1out,R2in,R2out : out std_logic);  --  R3 is PC so no need to control signals);   
	end Component;
	
	Component ALSU  is  
		port (a,b:in std_logic_vector (15 downto 0);
		s : in std_logic_vector(3 downto 0);
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		cout: out std_logic;
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic
		);    
	end Component ;
	
	Component my_nDFF is
	Generic ( n : integer := 16);
	port( Clk,Rst,EN : in std_logic;
	d : in std_logic_vector(n-1 downto 0);
	q : out std_logic_vector(n-1 downto 0));
	end Component;

	Component tri_state_buffer is
		Generic ( n : integer := 16);
		Port ( EN   : in  STD_LOGIC;    -- single buffer enable
			   Input  : in  STD_LOGIC_VECTOR (n-1 downto 0);
			   Output : out STD_LOGIC_VECTOR (n-1 downto 0));
	end Component;

	component ram is
	 port (
		clk : in std_logic;
		R,W : in std_logic;
		address : in std_logic_vector(15 downto 0);
		datain : in std_logic_vector(15 downto 0);
		dataout : out std_logic_vector(15 downto 0);
		MFC : out std_logic);
	end component;


signal data_bus : std_logic_vector(15 downto 0);
signal R0,R1,R2,PC : std_logic_vector(15 downto 0); -- 4 general purpose registers output
signal address,MDR,mem_data,IR,IR_Address : std_logic_vector(15 downto 0);		-- ram 
signal Z,Y,SRC,DST,TMP,ALSU_out,ALSU_Flags,FLAGS : std_logic_vector(15 downto 0);
signal internal_CLK : std_logic;		-- CLK of the ram
signal MDR_E,MFC : std_logic;	-- enable of MDR
signal MDR_input:std_logic_vector(15 downto 0);	-- input of MDR
signal Cout,Zero,Negative,Overflow,Y_RST,SPin_EN,SPout_EN : std_logic;
-- 4 general purpose registers signals --
signal R0in,R0out,R1in,R1out,R2in,R2out : std_logic;  --  R3 is PC so no need to control signals
	-- control signals --
	
	-- F1 signals --
signal PCout,MDRout,Zout,SPout,SRCout,DSTout,TMPout,Addressout : std_logic;

	-- F2 signals --
signal PCin,IRin,Zin,SPin : std_logic;

	-- F3 signals --
signal MARin,MDRin,TMPin : std_logic;

	-- F4 signals --
signal Yin,SRCin,DSTin : std_logic;

	-- F5 signals --
signal ALSUin : std_logic_vector(3 downto 0);

	-- F6 signals --
signal R,W,HLT : std_logic;

	-- F7 signal --
signal ClearY : std_logic;

	-- F8 signal --
signal Carryin : std_logic;


	-- F9 signal --
signal FLAGS_E : std_logic;

---------------------------------------------------------------------------
begin
internal_CLK<= CLK and (not HLT	);
	-- 4 general purpose registers --
R0_r: my_nDFF generic map(16) port map(internal_CLK,RST,R0in,data_bus,R0);	-- R0
R1_r: my_nDFF generic map(16) port map(internal_CLK,RST,R1in,data_bus,R1);	-- R1
SPin_EN<=R2in or SPin;
R2_r: my_nDFF generic map(16) port map(internal_CLK,RST,SPin_EN,data_bus,R2);	-- SP
R3_r: my_nDFF generic map(16) port map(internal_CLK,RST,PCin,data_bus,PC);	-- PC 
	
	-- 3 special purpose registers --
TMP_r:my_nDFF generic map(16) port map(internal_CLK,RST,TMPin,data_bus,TMP);	
SRC_r:my_nDFF generic map(16) port map(internal_CLK,RST,SRCin,data_bus,SRC);	
DST_r:my_nDFF generic map(16) port map(internal_CLK,RST,DSTin,data_bus,DST);	

	-- 2 ram Registers --
MDR_E <= MDRin or MFC;
MDR_input <= mem_data when MFC='1'
	else data_bus;	
MDR_r:my_nDFF generic map(16) port map(internal_CLK,RST,MDR_E,MDR_input,MDR);	
MAR_r:my_nDFF generic map(16) port map(internal_CLK,RST,MARin,data_bus,address);	

	-- 3 ALSU Registers --
Y_RST <= RST or ClearY;

Y_r:my_nDFF generic map(16) port map(internal_CLK,Y_RST,Yin,data_bus,Y);	
Z_r:my_nDFF generic map(16) port map(internal_CLK,RST,Zin,ALSU_out,Z);	
Flag_r:my_nDFF generic map(16) port map(internal_CLK,RST,FLAGS_E,ALSU_Flags,FLAGS);	


	-- IR register --
IR_r:my_nDFF generic map(16) port map(internal_CLK,RST,IRin,data_bus,IR);	

-------------------------------------------------------- tri_state_buffers --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

	-- 4 general purpose registers tri_state_buffers --
R0_t: tri_state_buffer generic map(16) port map(R0out,R0,data_bus);	-- R0
R1_t: tri_state_buffer generic map(16) port map(R1out,R1,data_bus);	-- R1
SPout_EN<=SPout or R2out;
R2_t: tri_state_buffer generic map(16) port map(SPout_EN,R2,data_bus);	-- SP
R3_t: tri_state_buffer generic map(16) port map(PCout,PC,data_bus);	-- PC

	-- 3 special purpose registers tri_state_buffers --
TMP_t:tri_state_buffer generic map(16) port map(TMPout,TMP,data_bus);	-- TMP
SRC_t:tri_state_buffer generic map(16) port map(SRCout,SRC,data_bus);	-- SRC
DST_t:tri_state_buffer generic map(16) port map(DSTout,DST,data_bus);	-- DST

	-- MDR tri_state_buffer --
MDR_t:tri_state_buffer generic map(16) port map(MDRout,MDR,data_bus);	-- MDR	

	-- Z register tri_state_buffer --
Z_t:tri_state_buffer generic map(16) port map(Zout,Z,data_bus);	-- Z


	-- Addressout tri state buffer --
IR_Address<=IR and "0000000011111111";
IR_t:tri_state_buffer generic map(16) port map(Addressout,IR_Address,data_bus);	-- Z

-------------------------------------------------------- Components --------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	
	-- RAM component --
Ram_comp: ram port map(internal_CLK,R,W,address,MDR,mem_data,MFC);

	-- ALSU component --
ALSU_comp: ALSU port map(Y,data_bus,ALSUin,Carryin,ALSU_out,Cout,Zero,Negative,Overflow);
ALSU_Flags(0) <= Cout;
ALSU_Flags(1) <= Zero;
ALSU_Flags(2) <= Negative;
ALSU_Flags(3) <= Overflow;	
	
	-- CU component --
CU_comp: CU port map(internal_CLK,RST,IR,FLAGS(1),Pcout,MDRout,Zout,SPout,SRCout,DSTout,TMPout,Addressout,PCin,IRin,Zin,SPin,MARin,MDRin,TMPin,Yin,SRCin,DSTin,ALSUin,R,W,HLT,ClearY,Carryin,FLAGS_E,R0in,R0out,R1in,R1out,R2in,R2out);

end arch;