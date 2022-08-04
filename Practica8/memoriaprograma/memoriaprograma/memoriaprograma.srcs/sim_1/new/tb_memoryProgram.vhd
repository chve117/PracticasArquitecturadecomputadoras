LIBRARY IEEE;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE IEEE.std_logic_TEXTIO.ALL; --PERMITE USAR STD_LOGIC 
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;
USE IEEE.std_logic_ARITH.ALL;
use IEEE.numeric_std.all;

entity tb_memoryProgram is
--  Port ( );
end tb_memoryProgram;

architecture Behavioral of tb_memoryProgram is

component memoryProgram is
    Port (
        PC : in STD_LOGIC_VECTOR(9 downto 0);
        Inst: out STD_LOGIC_VECTOR(24 downto 0));
end component;

signal PC: STD_LOGIC_VECTOR(9 downto 0);
signal Inst: STD_LOGIC_VECTOR(24 downto 0);

begin

    memory: memoryProgram PORT MAP
        (
            PC => PC,
            Inst => Inst
        );
    Stim_Process: process
        file ARCH_RES : TEXT;
        variable LINEA_RES : line;
        file ARCH_VEC : TEXT;
        variable LINEA_VEC : line;
        
        variable cadena: string(1 to 6);
        
    begin    
        file_open(ARCH_RES,"C:\Users\Hassan\Desktop\Practicasarqui\Practica8\memoriaprograma\ENTRADAS\SALIDAS", WRITE_MODE);
        cadena :="    PC";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="OPCODE";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="19..16";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="15..12";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="11...8";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="7....4";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        cadena :="3....0";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        
        writeline(ARCH_RES,LINEA_RES);
        wait for 100 ns;
        
        for i in 0 to 11 loop
        
        PC <= std_logic_vector(to_unsigned(i,10));
        wait for 60 ns;
        write(LINEA_RES, i, right, 7);
        write(LINEA_RES, Inst(24 downto 20), right, 7);
        write(LINEA_RES, Inst(19 downto 16), right, 7);
        write(LINEA_RES, Inst(15 downto 12), right, 7);
        write(LINEA_RES, Inst(11 downto 8), right, 7);
        write(LINEA_RES, Inst(7 downto 4), right, 7);
        write(LINEA_RES, Inst(3 downto 0), right, 7);

        writeline(ARCH_RES,LINEA_RES);
        
        
        end loop;
        
        file_close(ARCH_VEC);
        file_close(ARCH_RES);
        wait;
        
    end process;    
    
end Behavioral;