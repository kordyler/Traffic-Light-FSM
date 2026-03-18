// --- 1. ANA MODÜL (FSM) ---
module traffic_light_fsm (
    input  logic clk,
    input  logic reset,
    input  logic TAORB,
    output logic [1:0] LA,
    output logic [1:0] LB
);
    typedef enum logic [1:0] {S0, S1, S2, S3} state_t;
    state_t current_state, next_state;
    logic [3:0] timer;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0;
            timer <= 4'd0;
        end else begin
            current_state <= next_state;
            if (current_state != next_state)
                timer <= 4'd0;
            else if (current_state == S1 || current_state == S3)
                timer <= timer + 1;
        end
    end

    always_comb begin
        case (current_state)
            S0: next_state = (~TAORB) ? S1 : S0;
            S1: next_state = (timer >= 4'd4) ? S2 : S1;
            S2: next_state = (TAORB) ? S3 : S2;
            S3: next_state = (timer >= 4'd4) ? S0 : S3;
            default: next_state = S0;
        endcase
    end

    always_comb begin
        case (current_state)
            S0: begin LA = 2'b10; LB = 2'b00; end
            S1: begin LA = 2'b01; LB = 2'b00; end
            S2: begin LA = 2'b00; LB = 2'b10; end
            S3: begin LA = 2'b00; LB = 2'b01; end
            default: begin LA = 2'b00; LB = 2'b00; end
        endcase
    end
endmodule

// --- 2. TESTBENCH (AYNI DOSYADA) ---
module tb_traffic_light();
    logic clk, reset, TAORB;
    logic [1:0] LA, LB;

    // Ba?lant?y? garantiye al?yoruz
    traffic_light_fsm uut (
        .clk(clk),
        .reset(reset),
        .TAORB(TAORB),
        .LA(LA),
        .LB(LB)
    );

    always #5 clk = (clk === 1'b0);

    initial begin
        clk = 0; reset = 1; TAORB = 1;
        #20 reset = 0; 
        #40 TAORB = 0; 
        #150 TAORB = 1;
        #150 $stop;
    end
endmodule
