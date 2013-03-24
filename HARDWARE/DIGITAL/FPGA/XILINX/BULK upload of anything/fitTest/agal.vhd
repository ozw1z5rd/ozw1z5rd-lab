----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:03:48 11 not 23 not 2011 
-- Design Name: 
-- Module Name:    agal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;












entity agal is
    Port ( A : in STD_LOGIC_VECTOR (13 downto 0);
           romacc : in  STD_LOGIC;
           ideio0 : out  STD_LOGIC;
           ideio1 : out  STD_LOGIC;
			  automap : out STD_LOGIC;
			  clk: in STD_LOGIC; 
           nM1 : in  STD_LOGIC);
end agal;

architecture Behavioral of agal is

begin

	sg_mapterm : signal bit; 
	sg_mapcond : signal bit; 
	
	
	process ( A , romacc, ideio0, ideio1, automap, clk, nM1  ) 
	begin 
	
		ideio0 <= A(0)*A(01)* not A(02)* not A(03)* not A(04)*A(05)*A(07);
		ideio1 <= A(00)*A(01)*A(05)* not A(06)*A(07); 

		sg_mapterm	:=  not A(00)* not A(01)* not A(02)* not A(03)* not A(04)* not A(05)* not A(06)* not A(07)* not A(08)* not A(09)* not A(10)* not A(11)* not A(12)* not A(13)*romacc*M1
			+  not A(00)* not A(01)* not A(02)*A(03)* not A(04)* not A(05)* not A(06)* not A(07)* not A(08)* not A(09)* not A(10)* not A(11)* not A(12)* not A(13)*romacc*M1
			+  not A(00)* not A(01)* not A(02)*A(03)*A(04)*A(05)* not A(06)* not A(07)* not A(08)* not A(09)* not A(10)* not A(11)* not A(12)* not A(13)*romacc*M1
			+  not A(00)*A(01)*A(02)* not A(03)* not A(04)*A(05)*A(06)* not A(07)* not A(08)* not A(09)* not A(10)* not A(11)* not A(12)* not A(13)*romacc*M1
			+  not A(00)*A(01)*A(02)* not A(03)* not A(04)* not A(05)*A(06)*A(07)* not A(08)* not A(09)*A(10)* not A(11)* not A(12)* not A(13)*romacc*M1
			+  not A(00)*A(01)* not A(02)* not A(03)* not A(04)*A(05)*A(06)* not A(07)*A(08)* not A(09)*A(10)* not A(11)* not A(12)* not A(13)*romacc*M1;

		sg_mapcond := sg_mapterm
			+ mapcond* not M1
			+ mapcond* not romacc
			+ mapcond*A(13)
			+ mapcond* not A(12)
			+ mapcond* not A(11)
			+ mapcond* not A(10)
			+ mapcond* not A(09)
			+ mapcond* not A(08)
			+ mapcond* not A(07)
			+ mapcond* not A(06)
			+ mapcond* not A(05)
			+ mapcond* not A(04)
			+ mapcond* not A(03);

		if clk='1' then 
			mapcond  <= sg_mapcond;	
			automap  <= sg_mapcond;
		end if;
		
	end process;

end Behavioral;

