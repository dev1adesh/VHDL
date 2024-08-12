library ieee;
use ieee.std_logic_1164.all;

entity StateMachineProject is 
port
(
	rst : in std_logic;
	clk : in std_logic;  --50MHz
	sw  : in std_logic_vector(3 downto 1);
	led : out std_logic_vector(3 downto 1)

);
end entity;

architecture rtl of StateMachineProject is

component PLL6 IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
END component;

type DataTypeofSMState is (STATE1,STATE2,STATE3);

signal StateVariable : DataTypeofSMState;
signal clk_25MHZ : std_logic;



begin 

PLL1 : PLL6
	PORT MAP
	(
		areset		=> not(rst),
		inclk0		=> clk, --50MHz
		c0		 => clk_25MHZ --25MHz
	);


	Process1:process(rst, clk_25MHz)
	begin
		if rst = '0' then
		StateVariable <= STATE1;
		led <= "111";
		
	
		elsif rising_edge(clk_25MHz) then
		
			case StateVariable is
				
				when STATE1=>
					led <= "110";
					
					if sw(1) = '0' then 
						StateVariable <= STATE2;
					end if;
					
					
				when STATE2=>
					led <= "101";
					
					if sw(2) = '0' then 
						StateVariable <= STATE3;
					end if;
				
				when STATE3=>
					led <= "011";
					
					if sw(3) = '0' then 
						StateVariable <= STATE1;
					end if;
					
				when others =>
					StateVariable <= STATE1;
			
			end case;
			
		end if;


	end process;
end rtl;