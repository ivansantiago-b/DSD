----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2023 08:20:56 PM
-- Design Name: 
-- Module Name: control_unit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity control_unit_tb is
--  Port ( );
end control_unit_tb;

architecture Behavioral of control_unit_tb is
    signal clock, reset, go : std_logic;
    signal flags : std_logic_vector(2 downto 0);
    signal x_we, y_we, x_sel, y_sel, gcd_we : std_logic;
begin
dut:
    entity work.control_unit port map(clock => clock, reset => reset, go => go, flags => flags, x_we => x_we, y_we => y_we, x_sel => x_sel, y_sel => y_sel, gcd_we => gcd_we);
stimulus:
    process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        go <= '1';
        wait for 10 ns;
        flags <= "100";
        wait for 10 ns;
        flags <= "001";
        wait for 10 ns;
        flags <= "010";
        wait for 10 ns;
    end process;
end Behavioral;
