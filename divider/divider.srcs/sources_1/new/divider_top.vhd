----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2023 11:20:41 PM
-- Design Name: 
-- Module Name: divider_top - Behavioral
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

entity divider_top is
    port(
        clock, reset, go : in std_logic;
        x, y : in std_logic_vector(15 downto 0);
        d, m : out std_logic_vector(15 downto 0)
    );
end divider_top;

architecture Behavioral of divider_top is
    signal d_we, d_sel, d_en, i_we, y_we, result_we, b_we : std_logic;
    signal flags : std_logic_vector(2 downto 0);
begin
U0:
    entity work.divider_data_path port map(clock => clock, reset => reset, d_we => d_we, d_sel => d_sel, d_en => d_en, i_we => i_we, y_we => y_we, result_we => result_we, b_we => b_we, x => x, y => y, flags => flags, d => d, m => m);
U1:
    entity work.divider_unit_control port map(clock => clock, reset => reset, go => go, flags => flags, d_we => d_we, d_sel => d_sel, d_en => d_en, i_we => i_we, y_we => y_we, result_we => result_we, b_we => b_we);
end Behavioral;
