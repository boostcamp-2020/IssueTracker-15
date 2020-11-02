import request from "supertest";
import iconvLite from "mysql2/node_modules/iconv-lite";
import app from "../../src/app";

beforeAll(() => {
  iconvLite.encodingExists("");
});
describe("엔드포인트 /", () => {
  test("GET / 는 hello가 나와야 합니다.", async (done) => {
    const response = await request(app).get("/");

    expect(response.text).toBe("hello");
    done();
  });

  test("GET / 는 hello가 나오면 좋겠네요", async (done) => {
    const response = await request(app).get("/");

    expect(response.text).toBe("hello");
    done();
  });
});
