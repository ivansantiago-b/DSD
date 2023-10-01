----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/30/2023 01:01:51 PM
-- Design Name: 
-- Module Name: system_tb - Behavioral
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

entity system_tb is
--  Port ( );
end system_tb;

architecture Behavioral of system_tb is
    signal master_clock, reset, button : std_logic;
    signal x, y : std_logic_vector(7 downto 0);
    signal anodes : std_logic_vector(3 downto 0);
    signal cathodes : std_logic_vector(6 downto 0); 
begin
dut:
    entity work.system port map(x => x, y => y, master_clock => master_clock, reset => reset, button => button, anodes => anodes, cathodes => cathodes);
stimulus:
    process
    begin
        master_clock <= '0';
        wait for 5 ns;
        master_clock <= '1';
        wait for 5 ns;
    end process;
    x <= x"A4";
    y <= x"E8";
    
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        button <= '1';
        wait for 32 ms;
        button <= '0';
        wait for 4 ms;
        wait;
    end process;
end Behavioral;
