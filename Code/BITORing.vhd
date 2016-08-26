Library ieee;

Use ieee.std_logic_1164.all;

entity BITORing is
	port( IR : in std_logic_vector( 15 downto 0);
	NEXT_ADDRESS : in std_logic_vector( 7 downto 0);
	ORdst,ORresult,ORindsrc,ORinddst,OR2op,ORop,OR1op : in std_logic;
	uAR : out std_logic_vector(7 downto 0)
	);
end entity BITORing;

architecture struct of BITORing is

signal tmp_NEXT_ADDRESS : std_logic_vector( 7 downto 0);
signal tmp_signal : std_logic_vector( 17 downto 0);

begin
tmp_NEXT_ADDRESS(7) <= NEXT_ADDRESS(7);
tmp_NEXT_ADDRESS(6) <= NEXT_ADDRESS(6);
-- assigning NEXT_ADDRESS(5)
tmp_signal(0) <= IR(4) and ORdst;
tmp_signal(10) <= IR(10) and OR1op;
tmp_NEXT_ADDRESS(5) <= NEXT_ADDRESS(5) or tmp_signal(0) or tmp_signal(10);
-- assigning NEXT_ADDRESS(4)
tmp_signal(1) <= IR(3) and ORdst;
tmp_signal(11) <= IR(9) and OR1op;
tmp_NEXT_ADDRESS(4) <= NEXT_ADDRESS(4) or tmp_signal(1) or tmp_signal(11);
-- assigning NEXT_ADDRESS(3)
tmp_signal(2) <= ORdst and ( not IR(4) ) and ( not IR(3) ) and ( IR(2) );
tmp_signal(9) <= OR2op and IR(13);
tmp_signal(12) <= IR(8) and OR1op;
tmp_NEXT_ADDRESS(3) <= NEXT_ADDRESS(3) or tmp_signal(2) or tmp_signal(9) or tmp_signal(12);
-- assigning NEXT_ADDRESS(0)
tmp_signal(3) <= ( not IR(4) ) and ( not IR(3) ) and ( not IR(2) ) and ORresult;
tmp_signal(6) <= IR(10) and OR2op;
tmp_signal(15) <= IR(5) and OR1op;
tmp_signal(17) <= IR(14) and ORop;
tmp_NEXT_ADDRESS(0) <= NEXT_ADDRESS(0) or tmp_signal(3) or tmp_signal(6) or tmp_signal(15) or tmp_signal(17);
-- assigning NEXT_ADDRESS(2)
tmp_signal(7) <= ( IR(12) ) and OR2op;
tmp_signal(13) <= IR(7) and OR1op;
tmp_NEXT_ADDRESS(2) <= NEXT_ADDRESS(2) or tmp_signal(7) or tmp_signal(13);
-- assigning NEXT_ADDRESS(1)
tmp_signal(8) <= ( IR(11) ) and OR2op;
tmp_signal(4) <= ORindsrc and ( not IR(7) );
tmp_signal(5) <= ORinddst and ( not IR(2) );
tmp_signal(14) <= IR(6) and OR1op;
tmp_signal(16) <= IR(15) and ORop;
tmp_NEXT_ADDRESS(1) <= tmp_signal(8) or NEXT_ADDRESS(1) or tmp_signal(4) or tmp_signal(5) or tmp_signal(14) or tmp_signal(16);

uAR <= tmp_NEXT_ADDRESS;
end struct;
