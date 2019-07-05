"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var rxjs_1 = require("rxjs");
/**
 *
 * only keep the lastest source observable value until the inner observable complete,
 * then trigger the lastest source observable value
 *
 * @param isAbandon - is abandon inner observable value when there is newer source observable value
 *
 */
function waitMap(fn, isAbandon) {
    if (isAbandon === void 0) { isAbandon = true; }
    return function (preObs) {
        return rxjs_1.Observable.create(function (observer) {
            var closed = false;
            var latestRes;
            var resultSubp;
            var subp;
            var run = function (res) {
                var obs = fn(res);
                return obs.subscribe({
                    next: function (res) {
                        if (latestRes !== undefined && isAbandon) {
                            return;
                        }
                        observer.next(res);
                    },
                    error: function (err) {
                        closed = true;
                        observer.error(err);
                        resultSubp.unsubscribe();
                    },
                    complete: function () {
                        if (latestRes && !closed) {
                            var res_1 = latestRes;
                            latestRes = undefined;
                            run(res_1);
                        }
                    }
                });
            };
            resultSubp = preObs.subscribe({
                next: function (res) {
                    latestRes = res;
                    if (!subp || subp.closed) {
                        latestRes = undefined;
                        subp = run(res);
                    }
                },
                error: function (err) {
                    closed = true;
                    observer.error(err);
                },
                complete: function () {
                    closed = true;
                    observer.complete();
                }
            });
            return resultSubp;
        });
    };
}
exports.waitMap = waitMap;
