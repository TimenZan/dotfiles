# rxjs-operators 补完计划

> Too Young Too Simple, Sometimes Naive.

## operators

操作符    | 状态
-------   |-----
[bufferMap](https://github.com/iamcco/rxjs-operators/tree/master/src/bufferMap) | Done
[waitMap](https://github.com/iamcco/rxjs-operators/tree/master/src/waitMap) | Done

## install

```bash
yarn add rxjs-operators
```

## usage

```javascript
import { interval, timer } from 'rxjs'
import { map } from 'rxjs/operators'
import { bufferMap } from 'rxjs-operators'

interval(1000).pipe(
  bufferMap((arr) => {
   console.log('map:', arr);
   return timer(10000).pipe(
     map(() =>  arr)
   )
  })
).subscribe(res => console.log('sub:', res))
```
