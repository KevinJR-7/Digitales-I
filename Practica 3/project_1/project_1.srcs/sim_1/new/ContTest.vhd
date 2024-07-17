-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2023 03:34:56 PM
-- Design Name: 
-- Module Name: PBCounter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PBCounter_testb is
--  Port ( );
end PBCounter_testb;

architecture Behavioral of PBCounter_testb is
    component PBCounter
    port(CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PBTON : in  STD_LOGIC;
           Display: out STD_LOGIC_VECTOR(6 DOWNTO 0); 
           EN0 : out STD_LOGIC;
           EN1 : out STD_LOGIC;
           EN2 : out STD_LOGIC;
           EN3 : out STD_LOGIC
           );
    end component;
--    procedure cont_expected (
--         clk: in std_logic := '0';
--         reset: in std_logic :='0';
--         pbton: in std_logic := '0';
--         display: out STD_LOGIC_VECTOR(6 DOWNTO 0);
--         en0: out std_logic;
--         en1: out std_logic;
--         en2: out std_logic;
--         en3: out std_logic
--    ) is 
--    variable  conteo : std_logic_vector(9 downto 0);
--    variable conteo2 : std_logic_vector(1 downto 0);
--	variable CLK_1Hz : STD_LOGIC:='0';
--	variable CLK_16MSE : STD_LOGIC:='0';
--	variable count_clk : INTEGER:=0;
--	variable count_clk2 : INTEGER:=0;
--	variable clk_interno : STD_LOGIC:='0';
--    begin
--		if(clk_interno'event and clk_interno='1') then
--			if (count_clk = P100MSE) then
--				count_clk <= 0;
--				CLK_1Hz <= not CLK_1Hz;
--			else
--				count_clk <= count_clk +1;
--			end if;
--		end if;
----Componente No.2 
--	CONT: process(CLK_1Hz,RST)
--	begin
--		if (RST='1') then
--			conteo <= (others=>'0');
--		elsif (CLK_1Hz'event and CLK_1Hz='1') then
--			if(PBTON='1') then
--				if (conteo=999) then
--					conteo <= (others=>'0');
--				else
--					conteo <= conteo + 1;
--				end if;
--			else
--				conteo <= conteo;
--			end if;
--		end if;
--	end process;
	
----Componente No.3
--	BIN2BCD: BIN2BCD_0a999 PORT MAP(
--		BIN => conteo,
--		BCD2 => centenas,
--		BCD1 => decenas,
--		BCD0 => unidades
--	);
	
---- Componente No. 4
--    process (CLK)
--        begin  
--            if (CLK'event and CLK = '1') then
--                clk_interno <= NOT clk_interno;
--            end if;
--        end process;
	
---- Componente No.5 	
--		CLK_DIV2: process(clk_interno)
--	begin
--		if(clk_interno'event and clk_interno='1') then
--			if (count_clk2 = P16MSE) then
--				count_clk2 <= 0;
--				CLK_16MSE <= not CLK_16MSE;
--			else
--				count_clk2 <= count_clk2 +1;
--			end if;
--		end if;
--	end process;
	
---- componente No. 6
--	CONT2: process(CLK_16MSE,RST)
--	begin
--		if (RST='1') then
--			conteo2 <= (others=>'0');
--		elsif (CLK_16MSE'event and CLK_16MSE='1') then
--				if (conteo2=3) then
--					conteo2 <= (others=>'0');
--				else
--					conteo2 <= conteo2 + 1;
--			end if;
--		end if;
--	end process;
	
----Componente No. 7	

--selector: process(conteo2,centenas,decenas,unidades)
--	begin
--		case conteo2 is
--			when "00" =>
--				data_out <= centenas;
--				EN0 <='0';
--                EN1 <='1';
--                EN2 <='1';
--                EN3 <='1';
--			when "01" =>
--				data_out <= decenas;
--				EN0 <='1';
--                EN1 <='0';
--                EN2 <='1';
--                EN3 <='1';
--			when "10" =>
--				data_out <= unidades;
--				EN0 <='1';
--                EN1 <='1';
--                EN2 <='0';
--                EN3 <='1';
--			when others =>
--				data_out <= "0000";
--				EN0 <='1';
--                EN1 <='1';
--                EN2 <='1';
--                EN3 <='0';
--		end case;
--	end process;
---- Componente No. 8

--   segmentos <= "0000001" when (data_out="0000") else
--                "1001111" when (data_out="0001") else
--                "0010010" when (data_out="0010") else
--                "0000110" when (data_out="0011") else
--                "1001100" when (data_out="0100") else
--                "0100100" when (data_out="0101") else
--                "0100000" when (data_out="0110") else
--                "0001110" when (data_out="0111") else
--                "0000000" when (data_out="1000") else
--                "0000100" when (data_out="1001") else
--					 "1111110";
--		Display <= segmentos;
		
    
    
    
    
--   end cont_expected;
    Signal clk: std_logic := '0';
    Signal reset: std_logic:='0';
    Signal pbton: std_logic:='0';
    Signal display: STD_LOGIC_VECTOR(6 DOWNTO 0);
    Signal en0: std_logic := '0';
    Signal en1: std_logic :='0';
    Signal en2: std_logic:= '0';
    Signal en3: std_logic :='0';

begin

uut:  PBCounter PORT MAP (
			CLK => clk,
			PBTON => pbton,
			RST => reset,
			Display => display,
			EN0 => en0,
			EN1 => en1,
			EN2 => en2,
			EN3 => en3
		 );


clk <= not(clk) after 5ns;

process
    begin
    pbton <= '0';
    wait for 100ms;
    pbton <= '1';
    wait for 100ms;
    pbton <= '0';
    wait for 100ms;
    pbton <= '1';
    wait for 100ms;
    pbton <= '0';
    wait for 100ms;
    pbton <= '1';
    wait for 100ms;
    pbton <= '0';
    wait for 100ms;
    pbton <= '1';
    wait for 100ms;
    pbton <= '0';
    wait for 100ms;
    pbton <= '1';
    wait for 100ms;
end process;

process
    begin
    reset <= '1';
    wait for 20ns;
    reset <= '0';
    wait for 1000ms;
end process;
    
    
    
    
--process 
--    variable s : line;
--	variable proc_out : STD_LOGIC_VECTOR(7 downto 0);
--	variable count : integer := 0;


--begin
-- for i in 0 to 999 loop   
--          wait for 200ms;
--	      count := count + 1;
	      
	     
	      


    --if(

    

end Behavioral;
