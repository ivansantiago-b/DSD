----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 02:47:29 PM
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
    signal n : std_logic_vector(7 downto 0);
    signal anodes : std_logic_vector(3 downto 0);
    signal cathodes : std_logic_vector(6 downto 0);
begin
dut:
    entity work.system port map(master_clock => master_clock, reset => reset, button => button, n => n, anodes => anodes, cathodes => cathodes);
stimulus:
    process
    begin
        master_clock <= '0';
        wait for 5 ns;
        master_clock <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        button <= '1';
        wait for 10 ns;
        button <= '0';
        wait;
    end process;
    n <= x"FF";
end Behavioral;
