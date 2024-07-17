                                                                                             
library IEEE;                                                                                
use IEEE.STD_LOGIC_1164.ALL;                                                                 
                                                                                             
library UNISIM;                                                                              
use UNISIM.VComponents.all;                                                                  
                                                                                             
Entity funcion Is                                                                            
port (                                                                                       
		abc : in STD_LOGIC_VECTOR(2 downto 0);                                                     
		xyz : out STD_LOGIC_VECTOR(2 downto 0)                                                                        
	);                                                                                          
end funcion;                                                              
Architecture behavior of funcion Is   
    component nor2 port                                                              
    ( a, b : in std_logic;                   
              c : out std_logic                
         ); end component;
      
       component Inv port    
 ( a : in std_logic;
           b : out std_logic
      ); end component;    
         
                          
                
                
                                                                                             
--Signal xyz : STD_LOGIC_VECTOR(2 downto 0) := "000"; 
signal b2, c2, T, N: std_logic;   
signal w1: std_logic;                            
                                                                                          
begin
-- Comportamental

    process(abc)  
        begin
          case abc is
             when "001" | "101" | "110" | "100" => w1 <= '1';
             when others => w1 <= '0';
          end case;
    
    end process;
    xyz(0) <= w1;          
  
--Flujo de datos                                                                                     
    xyz(1) <= (not(abc(1)) or not(abc(0))) and (abc(2) or abc(0)); 

-- Nivel de puertas
INVb : inv port map(
    a => abc(1), b => b2
    );

INVc : inv port map(            
    a=> abc(0), b => c2
    );     
nor2_gate1: nor2 port map(
                a => b2,
                b => c2,
                c => T);
nor2_gate2: nor2 port map(
                a => abc(0), 
                b => abc(2), 
                c => N);
nor2_gate3: nor2 port map(
                a => T, b => N, c => xyz(2));                     
end behavior;                                        
                                        
                                        
