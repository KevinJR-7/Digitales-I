library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

--entity ROM_A is
--end ROM_A;

--architecture Behavioral of ROM_A is

--begin

--end Behavioral;
entity ROM_A is
    generic (
        M: integer := 8;
        N: integer := 4
    );
    port (
        add_a : in std_logic_vector(M-1 downto 0);
        outra : out std_logic_vector(N-1 downto 0)
    );
end entity ROM_A;

architecture Behavioral of ROM_A is
    type rom_type is array (0 to 2**M-1) of std_logic_vector(N-1 downto 0);
    constant rom : rom_type := (
       X"A",
       X"C",
       X"D",
       X"2",
       X"4",
       X"6",
       X"7",
       X"3"
    );
begin
    process(add_a)
    begin
        Outra <= rom(conv_integer(unsigned(add_a)));
    end process;
end Behavioral;
