----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 06:06:07 PM
-- Design Name: 
-- Module Name: system - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity system is
    port(
        clock, clear, go_flag : in std_logic;
        n : in std_logic_vector(11 downto 0);
        anodes : out std_logic_vector(3 downto 0);
        cathodes : out std_logic_vector(6 downto 0)
    );
end system;

architecture Behavioral of system is
    signal i_flag, n_flag, dd_flag : std_logic;
    signal ram_we, n_we, i_we, x_we, y_we, o_we, sh_we, sh_se : std_logic;
    signal ri_sel, wa_sel, i_sel, y_sel, sh_sel : std_logic;
    signal ra_sel : std_logic_vector(1 downto 0);
    signal r, i_ext : std_logic_vector(11 downto 0);
    signal bcd : std_logic_vector(15 downto 0);
    signal display_clock : std_logic;
begin
    FD:
        process(clock, clear)
        variable counter : std_logic_vector(18 downto 0);
        begin
            if clear = '1' then
                counter := (others => '0');
            elsif rising_edge(clock) then
                counter := std_logic_vector(unsigned(counter) + 1);
            end if;
            display_clock <= counter(18);
        end process FD;
    U0:
        entity work.data_path port map(clock => clock, clear => clear, ram_we => ram_we, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, o_we => o_we, sh_we => sh_we, sh_se => sh_se, ri_sel => ri_sel, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, sh_sel => sh_sel, ra_sel => ra_sel, n_in => n, r => r, i_ext => i_ext, i_flag => i_flag, n_flag => n_flag, dd_flag => dd_flag, o => bcd);
    U1:
        entity work.control_unit port map(clock => clock, clear => clear, go_flag => go_flag, i_flag => i_flag, n_flag => n_flag, dd_flag => dd_flag, ram_we => ram_we, n_we => n_we, i_we => i_we, x_we => x_we, y_we => y_we, o_we => o_we, sh_we => sh_we, sh_se => sh_se, ri_sel => ri_sel, wa_sel => wa_sel, i_sel => i_sel, y_sel => y_sel, sh_sel => sh_sel, ra_sel => ra_sel, r => r, i_ext => i_ext);
    U3:
        entity work.mux7seg port map(clock => display_clock, clear => clear, bcd => bcd, anodes => anodes, cathodes => cathodes);
end Behavioral;
