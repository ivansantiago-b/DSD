----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 03:50:27 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port(
        clock, clear, go_flag, i_flag, n_flag, dd_flag : in std_logic;
        ram_we, n_we, i_we, x_we, y_we, o_we, sh_we, sh_se : out std_logic;
        ri_sel, wa_sel, i_sel, y_sel, sh_sel : out std_logic;
        ra_sel : out std_logic_vector(1 downto 0);
        r, i_ext : out std_logic_vector(11 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (START, INPUT, A1, A2, AX, AY, AZ, PUSH, TEST_I, TEST_N, AN, DD_INPUT, DD_SHIFT, DD_UPDATE, DONE);
    signal current_state, next_state : state_t;
begin
    process(clock, clear)
    begin
        if clear = '1' then
            current_state <= START;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process;
    
    process(current_state, go_flag, n_flag, i_flag, dd_flag)
    begin
        case current_state is
            when START =>
                if go_flag = '1' then
                    next_state <= INPUT;
                else
                    next_state <= START;
                end if;
                -- Output
                ri_sel <= '1';          -- Ram input = R
                r <= x"000";
                wa_sel <= '0';          -- Write address = I
                i_sel <= '1';           -- I
                i_ext <= x"000";
                i_we <= '1';
                ram_we <= '1';
            when INPUT =>
                next_state <= A1;
                -- Ouput
                n_we <= '1';
                i_sel <= '0';
                i_we <= '1';
                ri_sel <= '1';
                r <= x"001";
                ram_we <= '0';
            when A1  =>
                next_state <= A2;
                -- Ouput
                ram_we <= '1';
            when A2 =>
                next_state <= TEST_N;
                -- Ouput
                i_we <= '0';
            when TEST_N =>
                if n_flag = '1' then
                    next_state <= DD_INPUT;
                else
                    next_state <= AX;
                end if;
                -- Ouput
                ram_we <= '0';
            when AX =>
                next_state <= AY;
                -- Output
                ra_sel <= "00";
                x_we <= '1';
                i_we <= '1';
            when AY =>
                next_state <= AZ;
                -- Output
                ra_sel <= "01";
                i_we <= '0';
                x_we <= '0';
                y_sel <= '1';
                y_we <= '1';
            when AZ =>
                next_state <= PUSH;
                -- Output
                ra_sel <= "11";
                y_sel <= '0';
                y_we <= '1';
            when PUSH =>
                next_state <= TEST_I;
                -- Ouput
                y_we <= '0';
                wa_sel <= '0';
                ri_sel <= '0';
                ram_we <= '1';
            when TEST_I =>
                if i_flag = '1' then
                    next_state <= DD_INPUT;
                else
                    next_state <= AX;
                end if;
                -- Output
                ram_we <= '0';
            when DD_INPUT =>
                -- Transition
                next_state <= DD_SHIFT;
                -- Output
                i_sel <= '1';
                i_ext <= x"000";
                i_we <= '1';
                ra_sel <= "10";
                sh_sel <= '1';
                sh_we <= '1';
                sh_se <= '0';
            when DD_SHIFT =>
                -- Transition
                if dd_flag = '1' then
                    next_state <= DONE;
                else
                    next_state <= DD_UPDATE;
                end if;
                -- Output
                sh_we <= '0';
                sh_se <= '1';
                i_we <= '0';
            when DD_UPDATE =>
                -- Transition
                next_state <= DD_SHIFT;
                -- Output
                sh_sel <= '0';
                sh_se <= '0';
                sh_we <= '1';
                i_sel <= '0';
                i_we <= '1';
            when DONE =>
                -- Transition
                next_state <= DONE;
                -- Output
                sh_se <= '0';
                o_we <= '1';
            when others =>
                null;
        end case;
    end process;
end Behavioral;
