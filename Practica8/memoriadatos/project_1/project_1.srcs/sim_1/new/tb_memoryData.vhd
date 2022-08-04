LIBRARY IEEE;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE IEEE.std_logic_TEXTIO.ALL; --PERMITE USAR STD_LOGIC 
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;
USE IEEE.std_logic_ARITH.ALL;

entity tb_memoryData is
end tb_memoryData;

architecture Behavioral of tb_memoryData is

component memoryData is
    generic(
        p: integer := 11; 
        n: integer := 16 
    );
    Port (
        dir : in STD_LOGIC_VECTOR(10 downto 0);
        dataIn: in STD_LOGIC_VECTOR (15 downto 0);
        clk, wd : in STD_LOGIC;
        dataOut: out STD_LOGIC_VECTOR(15 downto 0));
end component;


signal dir: STD_LOGIC_VECTOR(10 downto 0);
signal dataIn:  STD_LOGIC_VECTOR (15 downto 0);
signal clk,wd: STD_LOGIC;


signal dataOut: STD_LOGIC_VECTOR (15 downto 0);


constant CLK_period : time := 60 ns;

begin

    memory:memoryData PORT MAP
        ( dir => dir,
          dataIn => dataIn,
          clk => clk,
          wd => wd,
          dataOut => dataOut
        );

    CLK_PROCESS: process
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
     
        variable cadena: string(1 to 7);
        
        variable VAR_DIR: STD_LOGIC_VECTOR(10 downto 0);
        variable VAR_DATAIN,VAR_DATAOUT: STD_LOGIC_VECTOR (15 downto 0);
        variable VAR_WD: STD_LOGIC;
        
    begin 
        file_open(ARCH_VEC,"C:\Users\Hassan\Desktop\Practicasarqui\Practica8\Resulvec\VECTORES.txt", READ_MODE);
        file_open(ARCH_RES,"C:\Users\Hassan\Desktop\Practicasarqui\Practica8\Resulvec\RESULTADOS.txt", WRITE_MODE);
        
        CADENA :="    add";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA :="     WD";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA :=" dataIn";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA :="dataOut";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        
        writeline(ARCH_RES,LINEA_RES);
        wait for 100 ns;
        
        for i in 0 to 11 loop
            readline(ARCH_VEC, LINEA_VEC);
            Hread(LINEA_VEC, VAR_DIR);
            dir<=VAR_DIR;
            read(LINEA_VEC,VAR_WD);
            WD<=VAR_WD;
            Hread(LINEA_VEC,VAR_DATAIN);
            dataIn<=VAR_DATAIN;
            
            wait until rising_edge(clk);
            VAR_DATAOUT := dataOut;
            
            Hwrite(LINEA_RES, VAR_DIR, right, 8);
            write(LINEA_RES, VAR_WD, right, 8);
            Hwrite(LINEA_RES, VAR_DATAIN, right, 8);
            Hwrite(LINEA_RES, VAR_DATAOUT, right, 8);
            
            writeline(ARCH_RES,LINEA_RES);
        end loop;    
        file_close(ARCH_VEC);
        file_close(ARCH_RES);
        wait;
    end process;


end Behavioral;