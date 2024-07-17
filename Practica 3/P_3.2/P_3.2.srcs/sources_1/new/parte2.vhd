library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity parte2 is
generic(
M:integer:=3;
N:integer:=4
);
port(
    FA: in std_logic;
    FB: in std_logic;
    EN0: in std_logic ;
    EN1: in std_logic ;
    sel_alu: in std_logic_vector (2 downto 0);
    add_A: in std_logic_vector (M-1 downto 0);
    add_b: in std_logic_vector (M-1 downto 0);
    dataA: in std_logic_vector (N-1 downto 0);
    dataB: in std_logic_vector (N-1 downto 0);
    clk: in std_logic ;
    rst: in std_logic ;
    O: out std_logic_vector (6 downto 0)
   
);
end parte2;

architecture Behavioral of parte2 is
signal ba: std_logic_vector(N-1 downto 0);
signal bb: std_logic_vector(N-1downto 0);
signal ra: std_logic_vector(N-1downto 0);
signal rb: std_logic_vector(N-1downto 0);
signal ralu: std_logic_vector(N-1 downto 0);
signal s: std_logic_vector(N-1 downto 0);
signal clk_interno: std_logic;
signal carry: std_logic;
signal Dis: std_logic_vector(6 downto 0);

component ROM_A is
generic(
M:integer:=3;
N:integer:=4
);
port(
add_A: in std_logic_vector (M-1 downto 0);
outra: out std_logic_vector (N -1 downto 0)
);end component;

component ROM_B is
generic(
M:integer:=3;
N:integer:=4
);
port(
add_B: in std_logic_vector (M-1 downto 0);
outrb: out std_logic_vector (N -1 downto 0)
);
end component;

component ALU is
port(
A, B : in  std_logic_vector(3 downto 0);
          xyz : in  std_logic_vector(2 downto 0); 
          cout: out std_logic :='0';
          S : out std_logic_vector(3 downto 0)
);
end component;


-- Componente No. 4
signal count_clk : INTEGER:=0;
constant P100MSE : INTEGER := 5000000;
signal ROMaout: std_logic_vector(N-1 downto 0);
signal ROMbout: std_logic_vector(N-1 downto 0);
signal CLK_1Hz: std_logic;
begin
RomA : ROM_A port map(
    add_a => add_a,
    outra => ROMAout
    );
 RomB : ROM_B port map(
    add_b => add_b,
    outrb => ROMbout
    );
ALU1: ALU port  map(
    A => ra,
    B => rb,
    xyz => sel_alu,
    cout => carry,
    s => s
     
);
    process (clk)
        begin  
            if (CLK'event and CLK = '1') then
                clk_interno <= NOT clk_interno;
            end if;
        end process;
CLK_DIV: process(clk_interno)
begin
if(clk_interno'event and clk_interno='1') then
         if (count_clk = P100MSE) then
            count_clk <= 0;
            CLK_1Hz <= not CLK_1Hz;
     else
    count_clk <= count_clk +1;
end if;
end if;
end process;

process(ClK_1Hz , rst)
  begin
      if(rst='1') then
      ra <= (others => '0');
          elsif(CLK_1Hz'event and CLK_1Hz='1') then
              if(en0 = '1') then
                 RA <= BA;
              end if;
       end if;
end process;

process(ClK_1Hz , rst)
  begin
      if(rst='1') then
      rb <= (others => '0');
          elsif (CLK_1Hz'event and CLK_1Hz='1') then
        if(en0 = '1') then
        Rb <= Bb;
        end if;
    end if;
end process;

process(ClK_1Hz , rst)
  begin
      if(rst='1') then
      ralu <= (others => '0');
          elsif (CLK_1Hz'event and CLK_1Hz='1') then
        if(en0 = '1') then
        ralu <= s;
        end if;
    end if;
end process;

process(ClK_1Hz , rst)
  begin
      if(rst='1') then
      ra <= (others => '0');
          elsif (CLK_1Hz'event and CLK_1Hz='1') then
        if(en0 = '1') then
        RA <= BA;
        end if;
    end if;
end process;
process(ROMaout, DataA,FA)
    begin
        if(FA='1') then
        BA <=DataA;
    else
        BA <= ROMaout;
    end if;
end process;

process(ROMbout, DataB,FB)
    begin
        if(FB='0') then
            BB <= DataB;
        else
            BB <= ROMbout;
        end if;
end process;   
    process(Dis,s)
    begin
    case S is
    when "0000" => dis <="0000001";
    when "0001" => dis <="1001111";
    when "0010" => dis <="0010010";
    when "0011" => dis <="0000110";
    when "0100" => dis <="1001100";
    when "0101" => dis <="0100100";
    when "0110" => dis <="1100000";
    when "0111" => dis <="0001110";
    when "1000" => dis <="0000000";
    when "1001" => dis <="0000100";
    when "1010" => dis <="1111110";
    when "1011" => dis <="0110000";
    when "1100" => dis <="1101101";
    when "1101" => dis <="1111001";
    when "1110" => dis <="0110011";
    when "1111" => dis <="1011011";
    when others => dis<= "0000000";
    end case;
    O <= dis;
end process;
end Behavioral;
