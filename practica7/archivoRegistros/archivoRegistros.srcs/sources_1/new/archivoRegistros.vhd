library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity archivoRegistros is
    Port ( writeReg : in STD_LOGIC_VECTOR (3 downto 0);
           writeData : in STD_LOGIC_VECTOR (15 downto 0);
           readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           WR : in STD_LOGIC;
           SHE : in STD_LOGIC;
           DIR : in STD_LOGIC;
           readData1 : out STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0));
end archivoRegistros;

architecture Behavioral of archivoRegistros is
type matrix is array (0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
signal registros : matrix;
begin
    process(clk,clr)
    begin
    
        if(clr = '1') then --Reset
            registros <= (others => (others => '0'));
        elsif(rising_edge(clk))then
            if(WR = '1') then
                if(SHE = '1') then --Corrimientos
                    if(DIR = '1') then --Corrimiento a la izquierda
                        registros(conv_integer(writeReg)) <= to_stdlogicvector(to_bitvector(registros(conv_integer(readReg1))) sll (conv_integer(shamt)));
                    else --Corrimiento a la derecha
                        registros(conv_integer(writeReg)) <= to_stdlogicvector(to_bitvector(registros(conv_integer(readReg1))) srl (conv_integer(shamt)));
                    end if;
                else --Carga
                    registros(conv_integer(writeReg))<= writeData;
                end if;
            end if;
        end if;
        
    end process;

    --Lectura
    readData1<=registros(conv_integer(readReg1));
    readData2<=registros(conv_integer(readReg2));
    
end Behavioral;
