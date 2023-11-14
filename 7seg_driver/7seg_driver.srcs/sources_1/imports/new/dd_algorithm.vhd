----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 01:14:50 AM
-- Design Name: 
-- Module Name: dd_algorithm - Behavioral
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

entity dd_algorithm is
    port(
        clock, clear, go : in std_logic;
        n : in std_logic_vector(12 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );
end dd_algorithm;

architecture Behavioral of dd_algorithm is
    signal we, se, n_sel, bcd_we, flag, clock7seg : std_logic;
    signal bcd : std_logic_vector(15 downto 0);
begin
control_unit:
    entity work.dd_control_unit port map(clock => clock, clear => clear, go => go, flag => flag, n_sel => n_sel, bcd_we => bcd_we, we => we, se => se);
data_path:
    entity work.dd_data_path port map(clock => clock, clear => clear, we => we, se => se, n_sel => n_sel, bcd_we => bcd_we, n => n, flag => flag, bcd => bcd);
fd:
    entity work.frequency_divider generic map(n => 19) port map(master_clock => clock, clear => clear, output_clock => clock7seg);
display_driver:
    entity work.mux_7seg port map(clock => clock7seg, clear => clear, bcd => bcd, anodes => anodes, cathodes => cathodes);
end Behavioral;
