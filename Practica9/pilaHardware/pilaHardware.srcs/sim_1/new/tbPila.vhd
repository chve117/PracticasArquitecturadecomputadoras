library IEEE;
LIBRARY STD;

USE STD.TEXTIO.ALL;
USE IEEE.std_logic_TEXTIO.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;
USE IEEE.std_logic_ARITH.ALL;


entity tbPila is
--  Port ( );
end tbPila;

architecture Behavioral of tbPila is

component pilaHardware is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           DW : in STD_LOGIC;
           UP : in STD_LOGIC;
           WPC : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           PCout : out STD_LOGIC_VECTOR (15 downto 0);
           SP : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal PCin, PCout: STD_LOGIC_VECTOR (15 downto 0);
signal SP: STD_LOGIC_VECTOR (2 downto 0);
signal DW, UP, WPC, clk, clr: STD_LOGIC;

constant CLK_period : time := 30 ns;
begin
    
    pila: pilaHardware PORT MAP
         ( PCin => PCin,
           DW => DW,
           UP => UP,
           WPC => WPC,
           clk => clk,
           clr => clr,
           PCout => PCout,
           SP => SP
         );
    
    CLK_Process: process
    begin
        clk <= '0';
		wait for CLK_period/2;
		clk <= '1';
		wait for CLK_period/2;
    end process;
    
    Stim_Process: process
    
    file ARCH_RES : TEXT;
    variable LINEA_RES : line;
   
    file ARCH_VEC : TEXT;
    variable LINEA_VEC : line;
    
    variable cadena: string(1 to 2);
    
    variable VAR_PCin, VAR_PCout: STD_LOGIC_VECTOR (15 downto 0);
    variable VAR_SP: STD_LOGIC_VECTOR (2 downto 0);
    variable VAR_DW, VAR_UP, VAR_WPC, VAR_CLR: STD_LOGIC;
    
    begin
        file_open(ARCH_VEC, "C:\Users\Hassan\Desktop\Practicasarqui\Practica9\resultados\VECTORES.txt", READ_MODE);
        file_open(ARCH_RES, "C:\Users\Hassan\Desktop\Practicasarqui\Practica9\resultados\RESULTADOS.txt", WRITE_MODE);  
        CADENA := "SP";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);
        CADENA := "PC";
        write(LINEA_RES, CADENA, left, CADENA'LENGTH+1);
        writeline(ARCH_RES,LINEA_RES);
        
        wait until rising_edge(clk);
        
        for i in 0 to 26 loop
            readline(ARCH_VEC, LINEA_VEC);
            -- CLR | WPC | UP | DW | PCin
            read(LINEA_VEC, VAR_CLR);
            clr <= VAR_CLR;
            read(LINEA_VEC, VAR_WPC);
            WPC <= VAR_WPC;
            read(LINEA_VEC, VAR_UP);
            UP <= VAR_UP;
            read(LINEA_VEC, VAR_DW);
            DW <= VAR_DW;
            Hread(LINEA_VEC, VAR_PCin);
            PCin <= VAR_PCin;
            
            wait until rising_edge(clk);
            
            VAR_SP := SP;
            VAR_PCout := PCout;
            
            write(LINEA_RES, conv_integer(VAR_SP), left, 3);
            write(LINEA_RES, conv_integer(VAR_PCout), left, 3);
            
            writeline(ARCH_RES,LINEA_RES);
        end loop;
                 
        file_close(ARCH_VEC);
        file_close(ARCH_RES);
 
        wait;
    end process;

end Behavioral;
