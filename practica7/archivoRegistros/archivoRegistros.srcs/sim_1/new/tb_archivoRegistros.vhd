LIBRARY IEEE;
LIBRARY STD;
USE STD.TEXTIO.ALL;
USE IEEE.std_logic_TEXTIO.ALL;	--PERMITE USAR STD_LOGIC 

USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;
USE IEEE.std_logic_ARITH.ALL;

entity tb_archivoRegistros is
--  Port ( );
end tb_archivoRegistros;

architecture Behavioral of tb_archivoRegistros is

component archivoRegistros is
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
end component;

--Entradas
signal writeReg, readReg1, readReg2, shamt : std_logic_vector(3 downto 0) := (others => '0');
signal writeData : std_logic_vector(15 downto 0) := (others => '0');
signal clk, clr, WR, SHE, DIR: std_logic := '0';

--Salidas
signal readData1,readData2 : std_logic_vector(15 downto 0);

--Clock
constant CLK_period : time := 60 ns;

begin

    ArchReg: archivoRegistros PORT MAP
         ( writeReg => writeReg,
           writeData => writeData,
           readReg1 => readReg1,
           readReg2 => readReg2,
           shamt => shamt,
           clk => clk,
           clr => clr,
           WR => WR,
           SHE => SHE,
           DIR => DIR,
           readData1 => readData1,
           readData2 => readData2
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
    
    variable cadena: string(1 to 5);
    
    variable RR1, RR2, WREG, VAR_SHAMT: std_logic_vector(3 downto 0);
    variable WD, RD1, RD2 : std_logic_vector(15 downto 0);
    variable VAR_CLR, VAR_WR, VAR_SHE, VAR_DIR: std_logic;
    
    begin
        file_open(ARCH_VEC, "C:\Users\Hassan\Desktop\Practicasarqui\practica7\entradaysalida\VECTORES.txt", READ_MODE);
        file_open(ARCH_RES, "C:\Users\Hassan\Desktop\Practicasarqui\practica7\entradaysalida\RESULTADOS.txt", WRITE_MODE);
        
        CADENA := "  RR1";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "  RR2";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "SHAMT";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := " WREG";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "   WD";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "   WR";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "  SHE";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "  DIR";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "  RD1";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        CADENA := "  RD2";
        write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
        writeline(ARCH_RES,LINEA_RES);
        
        wait for 100 ns;
        for i in 0 to 11 loop
            readline(ARCH_VEC, LINEA_VEC);
            -- CLR | RR1 | RR2 | SHAMT | WREG | WD | WR | SHE | DIR
            read(LINEA_VEC, VAR_CLR);
            clr<= VAR_CLR;
            Hread(LINEA_VEC, RR1);
            readReg1 <= RR1;
            Hread(LINEA_VEC, RR2);
            readReg2 <= RR2;
            Hread(LINEA_VEC, VAR_SHAMT);
            shamt <= VAR_SHAMT;
            Hread(LINEA_VEC, WREG);
            writeReg <= WREG;
            Hread(LINEA_VEC, WD);
            writeData <= WD;
            read(LINEA_VEC, VAR_WR);
            wr <= VAR_WR;
            read(LINEA_VEC, VAR_SHE);
            she <= VAR_SHE;
            read(LINEA_VEC, VAR_DIR);
            dir <= VAR_DIR;
             
            wait until rising_edge(clk);
            
            RD1 := readData1;
            RD2 := readData2;
            
            Hwrite(LINEA_RES, RR1, right, 6);
            Hwrite(LINEA_RES, RR2, right, 6);
            Hwrite(LINEA_RES, VAR_SHAMT, right, 6);
            Hwrite(LINEA_RES, WREG, right, 6);
            Hwrite(LINEA_RES, WD, right, 6);
            write(LINEA_RES, VAR_WR, right, 6);
            write(LINEA_RES, VAR_SHE, right, 6);
            write(LINEA_RES, VAR_DIR, right, 6);
            Hwrite(LINEA_RES, RD1, right, 6);
            Hwrite(LINEA_RES, RD2, right, 6);

            writeline(ARCH_RES,LINEA_RES);
            
        end loop;
        
        file_close(ARCH_VEC);
        file_close(ARCH_RES);
        
        wait;
    end process;
    
end Behavioral;