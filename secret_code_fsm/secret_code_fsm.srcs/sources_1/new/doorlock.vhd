----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 09:51:08 PM
-- Design Name: 
-- Module Name: doorlock - Behavioral
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

entity doorlock is
    port(
        clock, reset : in std_logic;
        secret_code : in std_logic_vector(7 downto 0);
        button : in std_logic_vector(1 downto 0);
        pass, fail : out std_logic
    );
end doorlock;

architecture Behavioral of doorlock is
    type state_t is (q0, q1, q2, q3, q4, q5, q6);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= q0;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process state_register;

input:
    process(current_state, button)
        begin
            case current_state is
                when q0 =>
                    if button = secret_code(1 downto 0) then
                        next_state <= q1;
                    else
                        next_state <= q4;
                    end if;
                when q1 =>
                    if button = secret_code(3 downto 2) then
                        next_state <= q2;
                    else
                        next_state <= q5;
                    end if;
                when q2 =>
                    if button = secret_code(5 downto 4) then
                        next_state <= q3;
                    else
                        next_state <= q6;
                    end if;
                when q3 =>
                    next_state <= q0;
                when q4 =>
                    next_state <= q5;
                when q5 =>
                    next_state <= q6;
                when q6 =>
                    next_state <= q0;
                when others =>
                    null;
            end case;
    end process input;

output:
    process(clock, reset)
        begin
            if reset = '1' then
                pass <= '0';
                fail <= '0';
            elsif rising_edge(clock) then
                if (current_state = q3) and (button = secret_code(7 downto 6)) then
                    pass <= '1';
                    fail <= '0';
                elsif (current_state = q3) or (current_state = q6) then
                    pass <= '0';
                    fail <= '1';
                else
                    pass <= '0';
                    fail <= '0';
                end if;
            end if;
    end process output;
end Behavioral;
