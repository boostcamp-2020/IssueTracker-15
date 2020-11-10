import { useEffect, useCallback } from "react";
import qs from "qs";
import { useHistory, useLocation } from "react-router-dom";
import { getJWTToken } from "../../lib/api";

function Callback() {
  const history = useHistory();
  const location = useLocation();

  useEffect(() => {
    async function getToken() {
      const { code } = qs.parse(location.search, {
        ignoreQueryPrefix: true,
      });

      try {
        const accessToken = await getJWTToken(code as string);
        localStorage.setItem("accessToken", accessToken);
        history.push("/");
      } catch (error) {
        alert("GitHub Login Error!");
      }
    }

    getToken();
  }, []);
  return null;
}

export default Callback;
