library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity ROM_B is
    generic (
        M: integer := 8;
        N: integer := 4
    );
    port (
        add_B : in std_logic_vector(M-1 downto 0);
        outrb : out std_logic_vector(N-1 downto 0)
    );
end entity ROM_B;

architecture Behavioral of ROM_B is
    type rom_type is array (0 to 2**M-1) of std_logic_vector(N-1 downto 0);
    constant rom : rom_type := (
       X"2",
       X"3",
       X"5",
       X"A",
       X"D",
       X"5",
       X"4",
       X"3"
    );
begin
    process(add_B)
    begin
        outrb <= rom(conv_integer(unsigned(add_B)));
    end process;
end Behavioral;
