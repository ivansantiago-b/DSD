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
        n : in std_logic_vector(7 downto 0);
        bcd : out std_logic_vector(11 downto 0)
    );
end dd_algorithm;

architecture Behavioral of dd_algorithm is
    signal we, se, n_sel, bcd_we, flag : std_logic;
begin
control_unit:
    entity work.dd_control_unit port map(clock => clock, clear => clear, go => go, flag => flag, n_sel => n_sel, bcd_we => bcd_we, we => we, se => se);
data_path:
    entity work.dd_data_path port map(clock => clock, clear => clear, we => we, se => se, n_sel => n_sel, bcd_we => bcd_we, n => n, flag => flag, bcd => bcd);
end Behavioral;
