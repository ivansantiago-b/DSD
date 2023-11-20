----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 03:50:07 PM
-- Design Name: 
-- Module Name: data_path - Behavioral
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

entity data_path is
    port(
        clock, clear : in std_logic;
        ram_we, n_we, i_we, x_we, y_we, o_we, sh_we, sh_se : in std_logic;
        ri_sel, wa_sel, i_sel, y_sel, sh_sel : in std_logic;
        ra_sel : in std_logic_vector(1 downto 0);
        n_in, r, i_ext : in std_logic_vector(11 downto 0);
        i_flag, n_flag, dd_flag : out std_logic;
        o : out std_logic_vector(15 downto 0)
    );
end data_path;

architecture Behavioral of data_path is
    signal read_address, write_address, ram_in, ram_out : std_logic_vector(11 downto 0);
    signal x, y, y_in, n, i, i_in : std_logic_vector(11 downto 0);
    signal sh, sh_in : std_logic_vector(27 downto 0);
begin
RAM:
    entity work.ram generic map(address_width => 12, data_width => 12) port map(clock => clock, we => ram_we, read_address => read_address, write_address => write_address, d => ram_in, q => ram_out);
    ram_in <= r when ri_sel = '1' else y;
    write_address <= n when wa_sel = '1' else i;
    with ra_sel select
        read_address <= i when "00",
                        x when "01",
                        n when "10",
                        std_logic_vector(unsigned(i) - unsigned(x)) when others;
N_REG:
    entity work.reg generic map(n => 12) port map(clock => clock, clear => clear, we => n_we, d => n_in, q => n);
I_REG:
    entity work.reg generic map(n => 12) port map(clock => clock, clear => clear, we => i_we, d => i_in, q => i);
    i_in <= i_ext when i_sel = '1' else std_logic_vector(unsigned(i) + 1);
X_REG:
    entity work.reg generic map(n => 12) port map(clock => clock, clear => clear, we => x_we, d => ram_out, q => x);
Y_REG:
    entity work.reg generic map(n => 12) port map(clock => clock, clear => clear, we => y_we, d => y_in, q => y);
    y_in <= ram_out when y_sel = '1' else std_logic_vector(unsigned(y) + unsigned(ram_out));
O_REG:
    entity work.reg generic map(n => 16) port map(clock => clock, clear => clear, we => o_we, d => sh(27 downto 12), q => o);
    n_flag <= '1' when unsigned(n) < 3 else '0';
    i_flag <= '1' when unsigned(i) = unsigned(n) else '0';
    dd_flag <= '1' when unsigned(i) = 11 else '0';
SH_REG:
    entity work.shift_reg generic map(n => 28) port map(clock => clock, clear => clear, sh => sh_se, we => sh_we, d => sh_in, q => sh);
    sh_in(11 downto 0) <= ram_out when sh_sel = '1' else sh(11 downto 0);
D0_DABBLE:
    entity work.dabble port map(input => sh(15 downto 12), output => sh_in(15 downto 12));
D1_DABBLE:
    entity work.dabble port map(input => sh(19 downto 16), output => sh_in(19 downto 16));
D2_DABBLE:
    entity work.dabble port map(input => sh(23 downto 20), output => sh_in(23 downto 20));
D3_DABBLE:
    entity work.dabble port map(input => sh(27 downto 24), output => sh_in(27 downto 24));
end Behavioral;
