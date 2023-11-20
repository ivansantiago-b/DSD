----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 06:25:28 PM
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
    signal clock, clear, go_flag : std_logic;
    signal n : std_logic_vector(11 downto 0);
    signal anodes : std_logic_vector(3 downto 0);
    signal cathodes : std_logic_vector(6 downto 0);
begin
    dut:
        entity work.system port map(clock => clock, clear => clear, go_flag => go_flag, n => n, anodes => anodes, cathodes => cathodes);
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
            clear <= '1';
            n <= x"00A";
            wait for 5 ns;
            clear <= '0';
            wait for 5 ns;
            go_flag <= '1';
            wait for 10 ns;
            go_flag <= '0';
            wait;
        end process;
end Behavioral;
