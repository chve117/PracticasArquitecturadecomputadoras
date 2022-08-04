library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity pilaHardware is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           DW : in STD_LOGIC;
           UP : in STD_LOGIC;
           WPC : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0);
           SP : out STD_LOGIC_VECTOR (2 downto 0));
end pilaHardware;

architecture Behavioral of pilaHardware is
type matrix is array (0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
signal contadores : matrix;
signal stackpointer : STD_LOGIC_VECTOR(2 downto 0);
begin
    process(clk,clr)
        variable var_sp: STD_LOGIC_VECTOR(2 downto 0);
    begin
        if(clr = '1') then --Reset
            contadores<= (others => (others => '0'));
            stackpointer<= "000";
        elsif(rising_edge(clk)) then    
            if(WPC = '1') then
                if(DW = '0') then
                    if(UP = '1') then
                        --CALL WPC=1 UP=1 DW=0 
                        var_sp:= stackpointer + 1;
                        stackpointer <= var_sp;
                    else
                        --BRANCH WPC=1 UP=0 DW=0
                        var_sp:= stackpointer;
                    end if;
                    contadores(conv_integer(var_sp)) <= PCin;
                end if;
            else 
                if(UP = '0') then
                    if(DW = '1') then
                        --RET WPC=0 UP=0 DW=1
                        var_sp:= stackpointer - 1;
                        stackpointer<= var_sp;
                    else
                        --Incremento WPC=0 UP=0 DW=0
                        var_sp:= stackpointer;
                    end if;
                    contadores(conv_integer(var_sp)) <= contadores(conv_integer(var_sp)) + 1;
                end if;
            end if;    
        end if;
        
    end process;
    
    --LECTURA
    PCout<=contadores(conv_integer(stackpointer));
    SP<=stackpointer;
    
end Behavioral;